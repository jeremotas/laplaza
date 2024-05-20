extends Node2D

var fDivisor = 1.0 # Variable para provocar al disminucion de tiempo de spawn de los enemigos
var iSecondsPassed = 0 # Variable para controlar la cantidad de tiempo sucedida
var TheGameStats : GameStats # Estadisticas del juego (control de experiencia y nivel)
var last_level = 0 # Marca para control del ultimo nivel accedido
var player_max_life = 20 # Maxima vida del jugador principal

# Variables de control de UI
@onready var HUD = $HUD
@onready var pause_menu = $PauseMenu
var paused = false

# Variables para el control de la camara
var zooming = ""
var zoom_high = Vector2(0.6, 0.6)
var zoom_back = Vector2(1, 1)
var zoom_speed = Vector2(0.3, 0.3)
var zoom_acceleration = 0.3
var original_zoom = Vector2()
var iStrategyCall = 0
var enemy_strategy

# Variable para control del malon.
var malon = [{"unit_type": "correntino", "quantity": 0}, {"unit_type": "granadero", "quantity": 0}, {"unit_type": "moreno", "quantity": 0}]

func _ready():
	get_viewport().set_physics_object_picking_sort(true) # 
	$UnitSpawner.set_goal($General) # Todas las unidades patricias siguen al general.
	TheGameStats = GameStats.new() # Reiniciamos las estadisticas
	TheGameStats._ready()
	$EnemyGoal.set_needed_units(Global.settings.game.enemy_goal)
	player_max_life = Global.settings.game.player_max_life
	enemy_strategy = Global.settings.enemy_spawn_strategy.duplicate()
	prepare_initial_conditions()
	prepare_enemy_spawns()
	
	
func prepare_initial_conditions():
	#print(JSON.stringify(malon))
	if "initial_conditions" in Global.settings.game:
		if "units_arrived" in Global.settings.game.initial_conditions: $EnemyGoal.UnitsArrived = Global.settings.game.initial_conditions.units_arrived
		if "life" in Global.settings.game.initial_conditions: $General.life = Global.settings.game.initial_conditions.life
		if "level" in Global.settings.game.initial_conditions: TheGameStats.set_level(Global.settings.game.initial_conditions.level)
		
		if "malon" in Global.settings.game.initial_conditions: 
			for index in range(malon.size()):
				var subgroup = malon[index]
				if subgroup.unit_type in Global.settings.game.initial_conditions.malon:
					var iCant = Global.settings.game.initial_conditions.malon.get(subgroup.unit_type)
					malon[index].quantity = iCant
		if "time" in Global.settings.game.initial_conditions: iSecondsPassed = Global.settings.game.initial_conditions.time
	#print(JSON.stringify(malon))	
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_stats() # Calculamos resultados
	HUD.change(TheGameStats) # Envio estadisticas a la interfaz
	if not (TheGameStats.game_over or TheGameStats.game_win):
		control_malon() # Gestionamos la composicion del malon
		zoom(delta) # Controlamos el movimiento de camara
		process_pause() # Revisamos si hubo pausa

func control_malon():
	var faction = "patricios"
	var max_alive = 0
	for subgroup in malon: # Revisamos para cada grupo si hay que agregar unidades
		var unit_type = subgroup.unit_type
		max_alive += subgroup.quantity
		# calculamos la cantidad en juego (dentro de la escena) y los que estan por venir (queue del spawner)
		var iQuantityInGame = get_tree().get_nodes_in_group("faccion_" + faction + "_" + unit_type).size() + $UnitSpawner.in_queue(faction, unit_type) 
		
		if iQuantityInGame  < subgroup.quantity:
			#print("queue spawn", unit_type)
			$UnitSpawner.queue_spawn_unit(faction, unit_type)
	$UnitSpawner.max_alive = max_alive

func calculate_stats():
	# Condicion de GAME OVER
	TheGameStats.game_over = ($General.life == 0 or $EnemyGoal.completed())
	TheGameStats.life = $General.life
	TheGameStats.max_life = player_max_life
	
	TheGameStats.plaza = $EnemyGoal.UnitsArrived
	TheGameStats.max_plaza = $EnemyGoal.NeededUnits
	
	TheGameStats.ingleses = get_tree().get_nodes_in_group("faccion_ingleses").size()
	TheGameStats.patricios = get_tree().get_nodes_in_group("faccion_patricios").size()
	
	# Revision de nivel
	if TheGameStats.level != last_level:
		$ChangeLevel.play()
		last_level = TheGameStats.level
		
		# Decision
		decision_time_start()
		
		# Agrega vida post-subida de nivel
		$General.life = max(Global.settings.game.min_player_life_after_level_up, $General.life)
		
		# Asigna el maximo posible de unidades en caso de spawneo automatico
		#assign_max_alive()
		
	if TheGameStats.game_over:
		game_over()
		
func game_over():
	Engine.time_scale = 0.3
	$General.modulate = Color("ff0000")
	await get_tree().create_timer(1).timeout
	Engine.time_scale = 1
	$General.modulate = Color("ffffff00")
	get_tree().change_scene_to_file("res://scenes/screens/gameover.tscn")

func decision_time_start():
	# Inicio de una decision
	Engine.time_scale = 0
	$decision_time.prepare_buttons(TheGameStats.experience)
	$decision_time.show()
	
func increase_life(increase):
	$General.life += increase

func decision_time_end(decision):
	# Ejecutar decision
	if decision == "granadero": add_unit_to_malon("granadero")
	elif decision == "correntino": add_unit_to_malon("correntino")
	elif decision == "moreno": add_unit_to_malon("moreno")
	elif decision == "upgrade_life": increase_life(10)
		
	# Devolver al juego
	$decision_time.hide()
	Engine.time_scale = 1
	
func add_unit_to_malon(unit_type):
	for i in range(malon.size()):
		if malon[i].unit_type == unit_type:
			malon[i].quantity += 1

func process_pause():
	# Controla si se ejecuto la pausa desde el input
	if Input.is_action_just_pressed("pause"):
		pauseMenu()	
	
	
func pauseMenu():
	# Funcion que determina que sucede durante la pausa (Engine stop y visual de control)
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
	pass
	
	
func zoom(delta):
	# Efecto que permite ver el area desde UN POCO mas arrriba.
	# Inicia con el boton de accept (SPACE o ENTER)
	if zooming == "" and Input.is_action_just_pressed("ui_accept"):
		zooming = "up"
		original_zoom = $General/Camera2D.zoom
		
	# Si esta en up disminuye el zoom hasta llegar a zoom_high
	if zooming == "up":
		$General/Camera2D.zoom += delta * -zoom_speed
		if $General/Camera2D.zoom <= zoom_high:
			zooming = "down"
			$General/Camera2D.zoom = zoom_high
			
	# Si llego a tope inicia el down en proceso inverso	
	if zooming == "down":
		$General/Camera2D.zoom +=  delta * zoom_speed
		if $General/Camera2D.zoom >= zoom_back:
			zooming = ""
			$General/Camera2D.zoom = original_zoom 
	
	
	
func assign_max_alive():
	# Determina el maximo cantidad de unidades vivas posibles conrtoladas por el spawn patricio
	#$UnitSpawner.max_alive = TheGameStats.level
	#$UnitSpawner2.max_alive = TheGameStats.level
	pass

#func _on_clickable_area_clicked_position(position):
	# Tengo una nueva posicion para ir.
#	new_position_order = position
#	for unidad in get_tree().get_nodes_in_group("unidades_seleccionadas"):
#		unidad.get_parent().go_to(new_position_order)


func _on_scene_timer_timeout():
	
	prepare_enemy_spawns()
	
	# Disminuye el spawn de los enemigos con el paso del tiempo.
	# A medida que avanza el divisor crece y el spawn time decrece (1 - 20, 2 - 10, 3 - 7.3, 4 - 5)
	# Aunque no siempre spawnean porque a veces la probabilidad de spawn no se cumple
	
		
	#var fMaxTime = 10.0
	#fDivisor = max(min(TheGameStats.get_level(), 10),1)

	#$EnemySpawner.set_rewspan_seconds(fMaxTime / fDivisor)
	#$EnemySpawner2.set_rewspan_seconds(fMaxTime / fDivisor)
	#$EnemySpawner3.set_rewspan_seconds(fMaxTime / fDivisor)
	#$EnemySpawner4.set_rewspan_seconds(fMaxTime / fDivisor)
	#$EnemySpawner5.set_rewspan_seconds(fMaxTime / fDivisor)
	
	#$EnemySpawner.probabilitySpawnOnTimer = 100 - (40 / fDivisor)
	#$EnemySpawner2.probabilitySpawnOnTimer = 100 - (40 / fDivisor)
	#$EnemySpawner3.probabilitySpawnOnTimer = 100 - (40 / fDivisor)
	#$EnemySpawner4.probabilitySpawnOnTimer = 100 - (40 / fDivisor)
	#$EnemySpawner5.probabilitySpawnOnTimer = 100 - (40 / fDivisor)
	
func prepare_enemy_spawns():
	if enemy_strategy.size() > 0:
		
		var strategy = enemy_strategy[0]
		
		while enemy_strategy.size() > 0 and strategy.min_time <= iSecondsPassed + 1:
			strategy = enemy_strategy.pop_front()
		
		print("NUEVA ESTRATEGIA ENEMIGA")
		print(JSON.stringify(strategy))
		$EnemySpawner.set_rewspan_seconds(strategy.spawn1.seconds)
		$EnemySpawner.probabilitySpawnOnTimer = strategy.spawn1.probability
		$EnemySpawner.set_unit_type(strategy.spawn1.unit_type)
		$EnemySpawner.controlled_max_alive = true 
		$EnemySpawner.max_alive = strategy.spawn1.max_alive
		
		$EnemySpawner2.set_rewspan_seconds(strategy.spawn2.seconds)
		$EnemySpawner2.probabilitySpawnOnTimer = strategy.spawn2.probability
		$EnemySpawner2.set_unit_type(strategy.spawn2.unit_type)
		$EnemySpawner2.controlled_max_alive = true 
		$EnemySpawner2.max_alive = strategy.spawn2.max_alive
		
		$EnemySpawner3.set_rewspan_seconds(strategy.spawn3.seconds)
		$EnemySpawner3.probabilitySpawnOnTimer = strategy.spawn3.probability
		$EnemySpawner3.set_unit_type(strategy.spawn3.unit_type)
		$EnemySpawner3.controlled_max_alive = true 
		$EnemySpawner3.max_alive = strategy.spawn3.max_alive
		
		$EnemySpawner4.set_rewspan_seconds(strategy.spawn4.seconds)
		$EnemySpawner4.probabilitySpawnOnTimer = strategy.spawn4.probability
		$EnemySpawner4.set_unit_type(strategy.spawn4.unit_type)
		$EnemySpawner4.controlled_max_alive = true 
		$EnemySpawner4.max_alive = strategy.spawn4.max_alive
		
		$EnemySpawner5.set_rewspan_seconds(strategy.spawn5.seconds)
		$EnemySpawner5.probabilitySpawnOnTimer = strategy.spawn5.probability
		$EnemySpawner5.set_unit_type(strategy.spawn5.unit_type)
		$EnemySpawner5.controlled_max_alive = true 
		$EnemySpawner5.max_alive = strategy.spawn5.max_alive


func _on_timer_timeout():
	# Control para el reloj del juego
	print(get_tree().get_nodes_in_group("faccion_ingleses").size())
	iSecondsPassed += 1
	HUD.change_time(iSecondsPassed)

func _on_death(faction, experience_given):
	# Sumador de experiencia
	if faction != $General.faction:
		TheGameStats.add_experience(experience_given)
		

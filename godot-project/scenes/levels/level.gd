extends Node2D

var fDivisor = 1.0 # Variable para provocar al disminucion de tiempo de spawn de los enemigos
var iSecondsPassed = 0 # Variable para controlar la cantidad de tiempo sucedida
var TheGameStats : GameStats # Estadisticas del juego (control de experiencia y nivel)
var last_level = 0 # Marca para control del ultimo nivel accedido
var player_max_life = 20 # Maxima vida del jugador principal

const enemy_strategy_container  = preload("res://scenes/levels/strategy_one.gd")
var enemy_strategy 
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
var command = ""
var spawn_zones = []
var last_strategy = "-" # Toma este valor inicial para que cuando hacemos las pruebas no se rompa en caso de empezar en un descanso.
var ActualTimeScale
var highscore = 0

# Variable para control del malon.
var malon = [
	{"unit_type": "correntino", "quantity": 0}, 
	{"unit_type": "granadero", "quantity": 0},
	{"unit_type": "moreno", "quantity": 0}, 
	{"unit_type": "arribeno", "quantity": 0}, 
	{"unit_type": "husares_infernales", "quantity": 0}
]
var EscuadronHusaresInfernales = preload("res://scenes/patricios/escuadron_husares_infernales.tscn")
var EscuadronCarpinchos = preload("res://scenes/patricios/escuadron_carpinchos.tscn")

func _ready():
	#get_viewport().set_physics_object_picking_sort(true) # 
	$BackgroundMusic.play(152.0)
	$UnitSpawner.set_goal($General) # Todas las unidades patricias siguen al general.
	TheGameStats = GameStats.new() # Reiniciamos las estadisticas
	TheGameStats._ready()
	$EnemyGoal.set_needed_units(Global.settings.game.enemy_goal)
	player_max_life = Global.settings.game.player_max_life
	
	enemy_strategy = enemy_strategy_container.new().strategy
	
	prepare_initial_conditions()
	prepare_enemy_spawns()
	
	Engine.time_scale = 1
	
	
func add_spawn_zone(zone):
	if not spawn_zones.has(zone):
		spawn_zones.push_back(zone)

func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			command += char(event.unicode)
	
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
	consume_enemy_strategies()
	
func consume_enemy_strategies():
	if enemy_strategy.size() > 0:	
		var strategy = enemy_strategy[0]
		while strategy.max_time < iSecondsPassed + 1:
			enemy_strategy.pop_front()
			strategy = enemy_strategy[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	calculate_stats() # Calculamos resultados
	HUD.change(TheGameStats) # Envio estadisticas a la interfaz
	if not (TheGameStats.game_over or TheGameStats.game_win):
		control_malon() # Gestionamos la composicion del malon
		zoom(delta) # Controlamos el movimiento de camara
		process_pause() # Revisamos si hubo pausa
	if command == "d10s":
		barrilete_cosmico()
		command = ""
	elif command == "dudu":
		decision_time_start()
		command = ""
	elif command == "roger":
		$General.activate_agua_hirviendo_level_up()
		command = ""
	elif command == "iddqd" and not $General.barrilete_cosmico:
		$General.invincible = not $General.invincible
		command = ""
	elif command == "idkfa":
		malon[0].quantity += 3 # Correntino
		malon[1].quantity += 2 # Granadero
		malon[2].quantity += 2 # Moreno
		malon[3].quantity += 1 # Arribeno
		command = ""
	elif command == "carp":
		carpinchos_run_call()
		command = ""
	

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
	TheGameStats.game_win = (iSecondsPassed >= Global.settings.game.player_goal)
	TheGameStats.life = $General.life
	TheGameStats.invincible = $General.invincible
	TheGameStats.max_life = player_max_life
	
	TheGameStats.plaza = $EnemyGoal.UnitsArrived
	TheGameStats.max_plaza = $EnemyGoal.NeededUnits
	
	TheGameStats.ingleses = get_tree().get_nodes_in_group("faccion_ingleses").size()
	TheGameStats.patricios = get_tree().get_nodes_in_group("faccion_patricios").size()
	
	# Revision de nivel
	if TheGameStats.level != last_level and not $General.barrilete_cosmico:
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
		
	if TheGameStats.game_win:
		game_win()
		
func game_win():
	Engine.time_scale = 0.3
	await get_tree().create_timer(1).timeout
	save_lagrimas(TheGameStats.experience)
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/screens/victory.tscn")		
		
func game_over():
	Engine.time_scale = 0.3
	$General.modulate = Color("ff0000")
	await get_tree().create_timer(1).timeout
	Engine.time_scale = 1
	$General.modulate = Color("ffffff00")
	
	save_lagrimas(TheGameStats.experience)
	
	
	get_tree().change_scene_to_file("res://scenes/screens/gameover.tscn")

func decision_time_start():
	# Inicio de una decision
	ActualTimeScale = Engine.time_scale
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
	elif decision == "arribeno": add_unit_to_malon("arribeno")
	elif decision == "ataque_husares_infernales": ataque_husares_infernales()
	elif decision == "barrilete_cosmico": barrilete_cosmico()
	elif decision == "upgrade_life": increase_life(10)
	elif decision == "ollas_del_pueblo": $General.activate_agua_hirviendo_level_up()
		
	# Devolver al juego
	$decision_time.hide()
	Engine.time_scale = ActualTimeScale
	
func barrilete_cosmico():
	$General.init_barrilete_cosmico()
	
func start_music():
	$BackgroundMusic.play()
	
func stop_music():
	$BackgroundMusic.stop()
	
func carpinchos_run_call():	
	var E = EscuadronCarpinchos.instantiate()
	
	var initAttack = Vector2.ZERO
	var endAttack = Vector2.ZERO
	initAttack.x = -1000
	initAttack.y = $General.global_position.y
	endAttack.x = 3000
	endAttack.y = $General.global_position.y 
	add_child(E)
	E.startAttack(initAttack, endAttack)
	
func ataque_husares_infernales():
	var E = EscuadronHusaresInfernales.instantiate()
	var initAttack = Vector2.ZERO
	var endAttack = Vector2.ZERO
	initAttack.x = -1000
	initAttack.y = $General.global_position.y - 50
	endAttack.x = 3000
	endAttack.y = $General.global_position.y - 150
	add_child(E)
	E.startAttack(initAttack, endAttack)
	
	$General/Camera2D.apply_shake_seconds(7)
	
func add_unit_to_malon(unit_type):
	for i in range(malon.size()):
		if malon[i].unit_type == unit_type:
			malon[i].quantity += 1

func process_pause():
	# Controla si se ejecuto la pausa desde el input
	if Input.is_action_just_pressed("pause") and Engine.time_scale > 0:
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
	
func prepare_enemy_spawns():
	if enemy_strategy.size() > 0:
		
		var strategy = enemy_strategy[0]
		
		if strategy.max_time < iSecondsPassed + 1:
			enemy_strategy.pop_front()
			if enemy_strategy.size() > 0:
				strategy = enemy_strategy[0]
		
		if strategy.name == last_strategy: return 
		print(iSecondsPassed," segundos ", strategy.name)
		$WaveTitle.speech(strategy.name)
		last_strategy = strategy.name
		for zone in spawn_zones:
			
			var unitSpawnArray = get_tree().get_nodes_in_group("spawn_" + zone)
			for unitSpawn in unitSpawnArray:
				unitSpawn.set_rewspan_seconds(strategy[zone].seconds)
				unitSpawn.probabilitySpawnOnTimer = strategy[zone].probability
				unitSpawn.set_unit_type(strategy[zone].unit_type)
				unitSpawn.controlled_max_alive = true 
				unitSpawn.max_alive = strategy.max_alive

func _on_timer_timeout():
	# Control para el reloj del juego
	print("Ingleses en juego: ", get_tree().get_nodes_in_group("faccion_ingleses").size())
	iSecondsPassed += 1
	HUD.change_time(max(Global.settings.game.player_goal - iSecondsPassed, 0))
	if iSecondsPassed - Global.settings.game.initial_conditions.time == 1:
		prepare_enemy_spawns()
		
	if iSecondsPassed == 120:
		carpinchos_run_call()
	elif iSecondsPassed == 480:
		carpinchos_run_call()

func _on_reward(faction, experience_given):
	# Sumador de experiencia
	if faction != $General.faction:
		TheGameStats.add_experience(experience_given)
		


func _on_timer_command_timeout():
	command = ""
	pass # Replace with function body.


func save_lagrimas(lagrimas):
	Global.save_data.lagrimas_acumuladas += lagrimas
	Global.save_data.save()
	pass
	

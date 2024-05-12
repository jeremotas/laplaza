extends Node2D

var fDivisor = 1.0 # Variable para provocar al disminucion de tiempo de spawn de los enemigos
var iSecondsPassed = 0 # Variable para controlar la cantidad de tiempo sucedida
var TheGameStats : GameStats # Estadisticas del juego (control de experiencia y nivel)
var last_level = 0 # Marca para control del ultimo nivel accedido
var player_max_life = 10 # Maxima vida del jugador principal

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

# Variable para control del malon.
var malon = [{"unit_type": "correntino", "quantity": 0}, {"unit_type": "granadero", "quantity": 0}]

func _ready():
	get_viewport().set_physics_object_picking_sort(true) # 
	$UnitSpawner.set_goal($General) # Todas las unidades patricias siguen al general.
	TheGameStats = GameStats.new() # Reiniciamos las estadisticas
	TheGameStats._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_stats() # Calculamos resultados
	HUD.change(TheGameStats) # Envio estadisticas a la interfaz
	process_pause() # Revisamos si hubo pausa
	control_malon() # Gestionamos la composicion del malon
	zoom(delta) # Controlamos el movimiento de camara

func control_malon():
	var faction = "patricios"
	for subgroup in malon: # Revisamos para cada grupo si hay que agregar unidades
		var unit_type = subgroup.unit_type
		# calculamos la cantidad en juego (dentro de la escena) y los que estan por venir (queue del spawner)
		var iQuantityInGame = get_tree().get_nodes_in_group("faccion_" + faction + "_" + unit_type).size() + $UnitSpawner.in_queue(faction, unit_type) 
		if iQuantityInGame  < subgroup.quantity:
			$UnitSpawner.queue_spawn_unit(faction, unit_type)

func calculate_stats():
	# Condicion de GAME OVER
	TheGameStats.game_over = ($General.life == 0 or $EnemyGoal.completed())
	
	# Revision de nivel
	if TheGameStats.level != last_level:
		$ChangeLevel.play()
		last_level = TheGameStats.level
		
		# Decision
		decision_time_start()
		
		# Agrega vida post-subida de nivel
		$General.life = player_max_life
		
		# Asigna el maximo posible de unidades en caso de spawneo automatico
		assign_max_alive() 
		
	if TheGameStats.game_over:
		get_tree().change_scene_to_file("res://scenes/screens/gameover.tscn")

func decision_time_start():
	# Inicio de una decision
	Engine.time_scale = 0
	$decision_time.prepare_buttons(TheGameStats.experience)
	$decision_time.show()
	
func increase_max_life(increase):
	player_max_life += increase

func decision_time_end(decision):
	# Ejecutar decision
	if decision == "granadero": add_unit_to_malon("granadero")
	elif decision == "correntino": add_unit_to_malon("correntino")
	elif decision == "upgrade_life": increase_max_life(10)
		
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
	$UnitSpawner.max_alive = TheGameStats.level
	#$UnitSpawner2.max_alive = TheGameStats.level

#func _on_clickable_area_clicked_position(position):
	# Tengo una nueva posicion para ir.
#	new_position_order = position
#	for unidad in get_tree().get_nodes_in_group("unidades_seleccionadas"):
#		unidad.get_parent().go_to(new_position_order)


func _on_scene_timer_timeout():
	# Disminuye el spawn de los enemigos con el paso del tiempo.
	# A medida que avanza el divisor crece y el spawn time decrece (1 - 20, 2 - 10, 3 - 7.3, 4 - 5)
	# Aunque no siempre spawnean porque a veces la probabilidad de spawn no se cumple
	fDivisor += 1.0
	var fMaxTime = 20.0
	$EnemySpawner.set_rewspan_seconds(fMaxTime / fDivisor)
	$EnemySpawner2.set_rewspan_seconds(fMaxTime / fDivisor)
	$EnemySpawner3.set_rewspan_seconds(fMaxTime / fDivisor)
	$EnemySpawner4.set_rewspan_seconds(fMaxTime / fDivisor)
	$EnemySpawner5.set_rewspan_seconds(fMaxTime / fDivisor)


func _on_timer_timeout():
	# Control para el reloj del juego
	iSecondsPassed += 1
	HUD.change_time(iSecondsPassed)

func _on_death(faction, experience_given):
	# Sumador de experiencia
	if faction != $General.faction:
		TheGameStats.add_experience(experience_given)
		

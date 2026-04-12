extends Control

const adentro = preload("res://assets/created/sounds/adentro.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.language = Global.save_data.language
	TranslationServer.set_locale(Global.language)
	$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/Comenzar.grab_focus()
	$Control/MarginContainer/HBoxContainer/CantidadLagrimas.text = str(Global.save_data.lagrimas_acumuladas)
	if Global.save_data.cantidad_sobres_pendientes() > 0:
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/AbrirSobre.text = tr("_ABRIR_SOBRES_") % str(Global.save_data.cantidad_sobres_pendientes()) 
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/AbrirSobre.disabled = false
	else:
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/AbrirSobre.text = "_SIN_SOBRES_"
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/AbrirSobre.disabled = true
	
	if Global.settings.demo:
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/AbrirSobre.disabled = true
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/AbrirSobre.focus_mode = Control.FOCUS_NONE
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/ElMazo.disabled = true
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/ElMazo.focus_mode = Control.FOCUS_NONE
	var aButtons = [
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/Comenzar,
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/ElMazo,
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/AbrirSobre,
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/Opciones,
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/Creditos,
		$Control/MarginContainer/TextureRect/MarginContainer/VBoxContainer/SalirOut
	]
	
	Global.prepare_buttons_menu(aButtons)
	
	
	load_volumes()
	load_malon()
	Global.iCounterMovesButtons = 1
	Engine.time_scale = 1
	get_tree().paused = false


	
func load_malon():
	$UnitSpawner.set_goal($PosicionGeneral)
	
	#var MejorasData = Global.save_data.mejoras
	#if MejorasData.arribenos > 0:
	#	for i in range(MejorasData.arribenos):
	#		$UnitSpawner.queue_spawn_unit('patricios', 'arribeno')
			
	#if MejorasData.correntinos > 0:
	#	for i in range(MejorasData.correntinos):
	#		$UnitSpawner.queue_spawn_unit('patricios', 'correntino')		
			
	#if MejorasData.granaderos > 0:
	#	for i in range(MejorasData.granaderos):
	#		$UnitSpawner.queue_spawn_unit('patricios', 'granadero')		
			
	#if MejorasData.morenos > 0:
	#	for i in range(MejorasData.morenos):
	#		$UnitSpawner.queue_spawn_unit('patricios', 'moreno')		
	
func load_volumes():
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(Global.save_data.master_mixer))
	bus_index = AudioServer.get_bus_index("Musica")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(Global.save_data.music_mixer))
	bus_index = AudioServer.get_bus_index("Efectos")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(Global.save_data.efectos_mixer))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_comenzar_pressed():
	AudioStreamManager.play({"stream": adentro, "volume": AVS.get_db("adentro_inicio_juego"), "pitch": AVS.get_rpitch("adentro_inicio_juego")})
	#get_tree().change_scene_to_file("res://scenes/levels/" + Global.settings.game.init_level + ".tscn")
	get_tree().change_scene_to_file("res://scenes/controls/pre_level_titles.tscn")
	


func _on_salir_pressed():
	get_tree().quit()


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://scenes/controls/opciones.tscn")


func _on_mejoras_pressed():
	get_tree().change_scene_to_file("res://scenes/controls/setup_mazo.tscn")


func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/credits.tscn")


func _on_abrir_sobre_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/nuevo_sobre.tscn")


func _on_timer_timeout() -> void:
	$Panel/TextureRect/Nubes.mover()

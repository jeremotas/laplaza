extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/MarginContainer/VBoxContainer/Comenzar.grab_focus()
	$Control/MarginContainer/HBoxContainer/CantidadLagrimas.text = str(Global.save_data.lagrimas_acumuladas)
	if Global.save_data.cantidad_sobres_pendientes() > 0:
		$Control/MarginContainer/VBoxContainer/AbrirSobre.text = "Abrir sobres (" +  str(Global.save_data.cantidad_sobres_pendientes()) + ")"
		$Control/MarginContainer/VBoxContainer/AbrirSobre.disabled = false
	else:
		$Control/MarginContainer/VBoxContainer/AbrirSobre.text = "Sin sobres"
		$Control/MarginContainer/VBoxContainer/AbrirSobre.disabled = true
	
	if Global.settings.demo:
		$Control/MarginContainer/VBoxContainer/AbrirSobre.disabled = true
		$Control/MarginContainer/VBoxContainer/AbrirSobre.focus_mode = Control.FOCUS_NONE
		$Control/MarginContainer/VBoxContainer/ElMazo.disabled = true
		$Control/MarginContainer/VBoxContainer/ElMazo.focus_mode = Control.FOCUS_NONE
		
	
	load_volumes()
	load_malon()
	
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

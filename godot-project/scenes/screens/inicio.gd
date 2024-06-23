extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/MarginContainer/VBoxContainer/Comenzar.grab_focus()
	$Control/MarginContainer/HBoxContainer/CantidadLagrimas.text = str(Global.save_data.lagrimas_acumuladas)
	load_volumes()
	
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
	get_tree().change_scene_to_file("res://scenes/levels/" + Global.settings.game.init_level + ".tscn")
	


func _on_salir_pressed():
	get_tree().quit()


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://scenes/controls/opciones.tscn")


func _on_mejoras_pressed():
	get_tree().change_scene_to_file("res://scenes/controls/mejoras.tscn")

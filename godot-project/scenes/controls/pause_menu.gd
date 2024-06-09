extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_menu_pressed():
	save_volume()
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")


func _on_continuar_pressed():
	save_volume()
	get_parent().pauseMenu()
	pass # Replace with function body.


func _on_visibility_changed():
	if visible:
		$MarginContainer/VBoxContainer/Continuar.grab_focus()

func save_volume():
	Global.save_data.master_mixer = $MarginContainer/VBoxContainer/master_mixer.value
	Global.save_data.music_mixer = $MarginContainer/VBoxContainer/music_mixer.value
	Global.save_data.efectos_mixer = $MarginContainer/VBoxContainer/efectos_mixer2.value
	Global.save_data.save()

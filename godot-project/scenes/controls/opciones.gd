extends CanvasLayer

func _ready():
	$MarginContainer/VBoxContainer2/Menu.grab_focus()

func _on_menu_pressed():
	save_options()
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")
	
func save_options():
	Global.save_data.master_mixer = $MarginContainer/VBoxContainer/master_mixer.value
	Global.save_data.music_mixer = $MarginContainer/VBoxContainer/music_mixer.value
	Global.save_data.efectos_mixer = $MarginContainer/VBoxContainer/efectos_mixer2.value
	Global.save_data.save()

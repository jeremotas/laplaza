extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var aButtons = [
		$MarginContainer/VBoxContainer/music_mixer,
		$MarginContainer/VBoxContainer/master_mixer,
		$MarginContainer/VBoxContainer/efectos_mixer2,
		$MarginContainer/VBoxContainer/Continuar,
		$MarginContainer/VBoxContainer/Salir
	]
	Global.prepare_buttons_menu(aButtons)
	#$PauseMusic.play()
	#play_pause_music(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_menu_pressed():
	save_volume()
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")
	play_pause_music(false)
	get_parent().play_background_music(true)
	


func _on_continuar_pressed():
	save_volume()
	get_parent().pauseMenu()
	get_parent().play_background_music(true)
	play_pause_music(false)


func _on_visibility_changed():
	if visible:
		get_parent().play_background_music(false)
		play_pause_music(true)
		$MarginContainer/VBoxContainer/Continuar.grab_focus()

func save_volume():
	Global.save_data.master_mixer = $MarginContainer/VBoxContainer/master_mixer.value
	Global.save_data.music_mixer = $MarginContainer/VBoxContainer/music_mixer.value
	Global.save_data.efectos_mixer = $MarginContainer/VBoxContainer/efectos_mixer2.value
	Global.save_data.save()


func play_pause_music(bPlay):
	if !bPlay:
		$PauseMusic.stop()
	else:
		$PauseMusic.play()

extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var aButtons = [
		$MarginContainer/VBoxContainer/GC/music_mixer,
		$MarginContainer/VBoxContainer/GC/master_mixer,
		$MarginContainer/VBoxContainer/GC/efectos_mixer2,
		$MarginContainer/VBoxContainer/Continuar,
		$MarginContainer/VBoxContainer/Salir
	]
	TranslationServer.set_locale(Global.language)
	Global.prepare_buttons_menu(aButtons)
		
	hslider_to($MarginContainer/VBoxContainer/GC/master_mixer, Color("FF5B93"))
	hslider_to($MarginContainer/VBoxContainer/GC/music_mixer, Color("C7FF5B"))
	hslider_to($MarginContainer/VBoxContainer/GC/efectos_mixer2, Color("5BADFF"))
	
	#$PauseMusic.play()
	#play_pause_music(false)
func hslider_to(oSlider, oColor):
	var sb = oSlider.get_theme_stylebox("grabber_area").duplicate()
	var sb2 = oSlider.get_theme_stylebox("grabber_area_highlight").duplicate()
	if sb is StyleBoxTexture:
		sb.modulate_color = oColor
		sb2.modulate_color = oColor
		oSlider.add_theme_stylebox_override("grabber_area", sb)
		oSlider.add_theme_stylebox_override("grabber_area_highlight", sb2)
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
	Global.save_data.master_mixer = $MarginContainer/VBoxContainer/GC/master_mixer.value
	Global.save_data.music_mixer = $MarginContainer/VBoxContainer/GC/music_mixer.value
	Global.save_data.efectos_mixer = $MarginContainer/VBoxContainer/GC/efectos_mixer2.value
	Global.save_data.save()


func play_pause_music(bPlay):
	if !bPlay:
		$PauseMusic.stop()
	else:
		$PauseMusic.play()

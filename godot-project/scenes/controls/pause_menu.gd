extends CanvasLayer

var bReadySinPercu = false

# Called when the node enters the scene tree for the first time.
func ready():
	var aButtons = [
		$MarginContainer/VBoxContainer/GC/music_mixer,
		$MarginContainer/VBoxContainer/GC/master_mixer,
		$MarginContainer/VBoxContainer/GC/efectos_mixer2,
		$MarginContainer/VBoxContainer/Continuar,
		$MarginContainer/VBoxContainer/Salir
	]
	TranslationServer.set_locale(Global.language)
	Global.prepare_buttons_menu(aButtons)
	
	prepare_sliders()
		
func prepare_sliders():
	hslider_to($MarginContainer/VBoxContainer/GC/master_mixer, Color("FF5B9388"))
	hslider_to($MarginContainer/VBoxContainer/GC/music_mixer, Color("C7FF5B88"))
	hslider_to($MarginContainer/VBoxContainer/GC/efectos_mixer2, Color("5BADFF88"))
	
	#$PauseMusic.play()
	#play_pause_music(false)
func hslider_to(oSlider, oColor):
	var sb = oSlider.get_theme_stylebox("grabber_area").duplicate()
	var sb2 = oSlider.get_theme_stylebox("grabber_area_highlight").duplicate()
	if sb is StyleBoxFlat:
		sb.bg_color = oColor.darkened(0.35)
		sb2.bg_color = oColor
		oSlider.add_theme_stylebox_override("grabber_area", sb)
		oSlider.add_theme_stylebox_override("grabber_area_highlight", sb2)


func _process(_delta):
	pass


func _on_menu_pressed():
	save_volume()
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")
	play_pause_music(false, 1)
	get_parent().play_background_music(true)
	


func _on_continuar_pressed():
	save_volume()
	get_parent().pauseMenu()
	get_parent().play_background_music(true)
	play_pause_music(false, 1)


func _on_visibility_changed():
	if visible:
		bReadySinPercu = false
		get_parent().play_background_music(false)
		play_pause_music(true, 1)
		$MarginContainer/VBoxContainer/Continuar.grab_focus()
		prepare_sliders()

func save_volume():
	Global.save_data.master_mixer = $MarginContainer/VBoxContainer/GC/master_mixer.value
	Global.save_data.music_mixer = $MarginContainer/VBoxContainer/GC/music_mixer.value
	Global.save_data.efectos_mixer = $MarginContainer/VBoxContainer/GC/efectos_mixer2.value
	Global.save_data.save()


func play_pause_music(bPlay, iWhichSong):
	if !bPlay:
		$PauseMusic.stop()
		$PauseMusicPercusion.stop()
	elif iWhichSong == 2:
		$PauseMusicPercusion.play()
	else:
		$PauseMusic.play()


func _on_pause_music_finished() -> void:
	bReadySinPercu = true
	play_pause_music(true, 2)

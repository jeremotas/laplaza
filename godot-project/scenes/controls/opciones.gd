extends CanvasLayer
var bMazoTest = false
var aLanguages = ["es", "en"]
var iSelectedLanguageIndex = -1

func _ready():
	TranslationServer.set_locale(Global.language)
	var aButtons = [
		$MarginContainer/VBoxContainer/ReiniciarMazo,
		$MarginContainer/VBoxContainer/ReiniciarMazoATest,
		$MarginContainer/VBoxContainer/GC/efectos_mixer2,
		$MarginContainer/VBoxContainer/GC/music_mixer,
		$MarginContainer/VBoxContainer/GC/master_mixer,
		$MarginContainer/VBoxContainer2/Menu,
		$MarginContainer/VBoxContainer/GC/Language
	]
	Global.prepare_buttons_menu(aButtons)
	iSelectedLanguageIndex = aLanguages.find(Global.language)
	
	hslider_to($MarginContainer/VBoxContainer/GC/master_mixer, Color("FF5B9388"))
	hslider_to($MarginContainer/VBoxContainer/GC/music_mixer, Color("C7FF5B88"))
	hslider_to($MarginContainer/VBoxContainer/GC/efectos_mixer2, Color("5BADFF88"))
	
		
	mover_caballo()
	$MarginContainer/VBoxContainer2/Menu.grab_focus()

func hslider_to(oSlider, oColor):
	var sb = oSlider.get_theme_stylebox("grabber_area").duplicate()
	var sb2 = oSlider.get_theme_stylebox("grabber_area_highlight").duplicate()
	if sb is StyleBoxFlat:
		sb.bg_color = oColor.darkened(0.35)
		sb2.bg_color = oColor
		oSlider.add_theme_stylebox_override("grabber_area", sb)
		oSlider.add_theme_stylebox_override("grabber_area_highlight", sb2)

func _on_menu_pressed():
	save_options()
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")
	
func save_options():
	Global.save_data.master_mixer = $MarginContainer/VBoxContainer/GC/master_mixer.value
	Global.save_data.music_mixer = $MarginContainer/VBoxContainer/GC/music_mixer.value
	Global.save_data.efectos_mixer = $MarginContainer/VBoxContainer/GC/efectos_mixer2.value
	Global.save_data.save()


func _on_confirmation_dialog_confirmed():
	if not bMazoTest:
		Global.save_data.original_cards = Global.save_data.reboot_cards
	else:
		Global.save_data.original_cards = []
	Global.save_data.save()
	Global.mazo = Mazo.crear(Global.save_data.original_cards)
	


func _on_reiniciar_mazo_pressed():
	bMazoTest = false
	$ConfirmationDialog.show()


func _on_reiniciar_mazo_a_test_pressed() -> void:
	bMazoTest = true
	$ConfirmationDialog.show()


func _on_before_language_pressed() -> void:
	iSelectedLanguageIndex = iSelectedLanguageIndex - 1
	if iSelectedLanguageIndex < 0:
		iSelectedLanguageIndex = aLanguages.size() - 1
	change_language()


func _on_next_language_pressed() -> void:
	iSelectedLanguageIndex = iSelectedLanguageIndex + 1
	if iSelectedLanguageIndex >= aLanguages.size():
		iSelectedLanguageIndex = 0
	change_language()
	
func change_language():
	Global.language = aLanguages[iSelectedLanguageIndex]
	Global.save_data.language = aLanguages[iSelectedLanguageIndex]
	Global.save_data.save()
	TranslationServer.set_locale(Global.language)	


func _on_language_pressed() -> void:
	iSelectedLanguageIndex = iSelectedLanguageIndex + 1
	if iSelectedLanguageIndex >= aLanguages.size():
		iSelectedLanguageIndex = 0
	change_language()


func mover_caballo():
	$Caballo.position.x = $Caballo.position.x + 30
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Caballo, "position:x", $Caballo.position.x - 30, 0.35)

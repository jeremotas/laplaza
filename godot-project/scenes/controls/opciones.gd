extends CanvasLayer
var bMazoTest = false
var aLanguages = ["es", "en"]
var iSelectedLanguageIndex = -1

func _ready():
	TranslationServer.set_locale(Global.language)
	var aButtons = [
		$MarginContainer/VBoxContainer/ReiniciarMazo,
		$MarginContainer/VBoxContainer/ReiniciarMazoATest,
		$MarginContainer/VBoxContainer/efectos_mixer2,
		$MarginContainer/VBoxContainer/music_mixer,
		$MarginContainer/VBoxContainer/master_mixer,
		$MarginContainer/VBoxContainer2/Menu,
		$MarginContainer/VBoxContainer/Language
	]
	Global.prepare_buttons_menu(aButtons)
	iSelectedLanguageIndex = aLanguages.find(Global.language)
	
	$MarginContainer/VBoxContainer2/Menu.grab_focus()

func _on_menu_pressed():
	save_options()
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")
	
func save_options():
	Global.save_data.master_mixer = $MarginContainer/VBoxContainer/master_mixer.value
	Global.save_data.music_mixer = $MarginContainer/VBoxContainer/music_mixer.value
	Global.save_data.efectos_mixer = $MarginContainer/VBoxContainer/efectos_mixer2.value
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

extends CanvasLayer
var bMazoTest = false
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

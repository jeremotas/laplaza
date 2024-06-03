extends Node

func _ready():
	$VBoxContainer/Reiniciar.grab_focus()

func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/" + Global.settings.game.init_level + ".tscn")


func _on_salir_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")


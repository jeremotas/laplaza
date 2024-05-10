extends Node

func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://game.tscn")


func _on_salir_pressed():
	get_tree().quit() # default behavior


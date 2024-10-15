extends Node

func _ready():
	$MarginContainer2/VBoxContainer/Panel/Wishlist.grab_focus()
	if $Personajes/General:
		$Personajes/General.celebration()

func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/" + Global.settings.game.init_level + ".tscn")


func _on_salir_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")



func _on_wishlist_pressed():
	OS.shell_open("http://laromero.com.ar/wishlist/")


func _on_steam_pressed():
	OS.shell_open("http://laromero.com.ar/wishlist/")
	pass # Replace with function body.

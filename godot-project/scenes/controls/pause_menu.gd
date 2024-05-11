extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")


func _on_continuar_pressed():
	get_parent().pauseMenu()
	pass # Replace with function body.


func _on_visibility_changed():
	$MarginContainer/VBoxContainer/Continuar.grab_focus()

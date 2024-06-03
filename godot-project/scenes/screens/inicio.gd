extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/MarginContainer/VBoxContainer/Comenzar.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_comenzar_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
	


func _on_salir_pressed():
	get_tree().quit()

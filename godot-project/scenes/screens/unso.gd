extends Control

@onready var AP = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	AP.play("La romero")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://scenes/screens/preinicio.tscn")

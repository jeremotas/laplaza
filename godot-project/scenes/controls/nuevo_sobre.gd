extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "up":
		$Sobre.start_particles()
		$Sobre.grab_focus()
	if anim_name == "to_white":
		$Sobre.hide()
		$AnimationPlayer.play("to_transparent")
	


func _on_sobre_pressed():
	$AnimationPlayer.play("to_white")

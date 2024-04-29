extends Character

@onready var animation = $AnimatedSprite2D
		
func go_to(new_destination):
	if selected:
		status.moving = true
		destination = new_destination
		$SelectionArea.set_selected(false)
	
func _process(delta):
	AnimationCalculation(delta)
	if animation_flip:
		animation.flip_h = true
	else:
		animation.flip_h = false
	animation.play(animation_selected)
	
func show_selection():
	if selected:
		$AnimatedSprite2D.material.set_shader_parameter("width", 1.0)
	else:
		$AnimatedSprite2D.material.set_shader_parameter("width", 0.0)
		

func _on_selection_area_selection_toggled(selection):
	selected = selection
	show_selection()

func _ready():
	pass

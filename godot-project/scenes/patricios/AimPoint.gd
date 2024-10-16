extends Node2D

@export var rotation_speed : float = TAU * 2
var theta : float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var last_input = get_parent().last_input
	position = last_input * 50
	if last_input != Vector2.ZERO:
		theta = wrapf(atan2(last_input.y, last_input.x) - rotation, -PI, PI)
		#rotation += clamp(rotation_speed * delta, 0, abs(theta)) * sign(theta)
		rotation += theta
		modulate = "ffffffff"
	else:
		modulate = "00000000"
	#print(last_input)

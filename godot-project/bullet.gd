extends Sprite2D

var direction = Vector2.ZERO
var speed = 400
var min_damage = 0
var max_damage = 0
var objective_faction = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction * speed * delta)
	pass


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func set_collision_mask(iLayer):
	$Area2D.set_collision_mask(iLayer)

func _on_area_2d_body_entered(body):
	#print(body, objective_faction)
	if body and ("faction" in body) and body.faction == objective_faction:
		set_process(false)
		if body.has_method("TakeDamage"):
			body.TakeDamage(min_damage, max_damage)
	queue_free()

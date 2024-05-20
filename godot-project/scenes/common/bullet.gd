extends Sprite2D

var direction = Vector2.ZERO
@export var speed = 150
@export var faction = ""
var min_damage = 0
var max_damage = 0
var objective_faction = null
var sound = ""
var is_playing = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func prepare():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction * speed * delta)
		
func set_color(TheColor):
	modulate = TheColor
	pass

func _on_visible_on_screen_enabler_2d_screen_exited():
	try_destroy()

func set_collision_mask(iLayer):
	$Area2D.set_collision_mask_value(iLayer, true)

func _on_area_2d_body_entered(body):
	#print(body, objective_faction)
	if body and ("faction" in body) and body.faction == objective_faction and body.life > 0:
		set_process(false)
		if body.has_method("TakeDamage"):
			body.TakeDamage(min_damage, max_damage)
		try_destroy()

func try_destroy():
	queue_free()
	

extends Sprite2D

var direction = Vector2.ZERO
@export var speed = 150
@export var faction = ""
@export var bullet_lifetime = 2
var min_damage = 0
var max_damage = 0
var objective_faction = null
var sound = ""
var is_playing = false
var bulletTimer = null
var explotionTimer = null
@export var one_hit = true
@export var explodes = false
@export var explotion_layer = 0
@export var explotion_lifetime = 2
@export var explotion_scale_radius = 10
@export var explotion_particle = false




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func prepare():
	pass
	
func prepare_explotion(layer, lifetime, scale_radius, particle):
	explodes = true
	one_hit = false
	explotion_layer = layer
	explotion_lifetime = lifetime
	explotion_scale_radius = scale_radius
	explotion_particle = particle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction * speed * delta)
		
func set_color(TheColor):
	modulate = TheColor
	pass

func _on_visible_on_screen_enabler_2d_screen_exited():
	#stopped()
	pass

func set_collision_mask(iLayer):
	if iLayer > 0:
		$Area2D.set_collision_mask_value(iLayer, true)

func _on_area_2d_body_entered(body):
	#print(body, objective_faction)
	if body and ("faction" in body) and body.faction == objective_faction and body.life > 0 and not body.invincible:
		set_process(false)
		if body.has_method("TakeDamage"):
			body.TakeDamage(min_damage, max_damage)
		if one_hit:
			stopped()

func stopped():
	if not explodes:
		try_destroy()
	else:
		create_explotion()
	
func try_destroy():
	queue_free()	
	
func create_explotion():
	if explotion_layer > 0:
		one_hit = false
		speed = 0
		$Area2D.scale = Vector2(explotion_scale_radius,explotion_scale_radius)
		$Area2D.set_collision_mask_value(explotion_layer, true)
		$ColorRect.visible = false
		#$Area2D/ExplotionRect.visible = true
		explotionTimer = Timer.new()
		add_child(explotionTimer)
		explotionTimer.autostart = true
		explotionTimer.wait_time = explotion_lifetime
		explotionTimer.one_shot = true
		explotionTimer.timeout.connect(try_destroy)
		explotionTimer.start()
		if explotion_particle:
			$explosion.visible = true
			$explosion.scale = Vector2(2,2)
		texture = null
	
	pass

func _on_visible_on_screen_enabler_2d_screen_entered():
	# tiempo que esta la bala o proyectil antes de desaparecer
	bulletTimer = Timer.new()
	add_child(bulletTimer)
	bulletTimer.autostart = true
	bulletTimer.wait_time = bullet_lifetime
	bulletTimer.one_shot = true
	bulletTimer.timeout.connect(stopped)
	bulletTimer.start()

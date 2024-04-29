extends CharacterBody2D
class_name Character

@export var faction = ""
@export var max_speed = 200
@export var speed = 0
@export var acceleration = 1200
@export var life = 10
@export var coolDownAttackTime = 3.0
@export var min_damage_given = 1
@export var max_damage_given = 1

var move_direction
var rng

var status = {"moving": false, "attacking": false, "hurt": false}



var destination = Vector2()
var movement = Vector2()
var animation_selected = "idle"
var animation_flip = false
var selected = false
var last_position = Vector2.ZERO
var inCoolDownAttack = false
var coolDownTimer = null

var comLabelString = ""


func add_to_faction(new_faction):
	faction = new_faction
	add_to_group("faccion_" + faction)

func go_to(new_destination, forced = false):
	if selected or forced:
		status.moving = true
		destination = new_destination
		if $SelectionArea:
			$SelectionArea.set_selected(false)

func takeDamage(min_damage, max_damage):
	var damage = rng.randi_range(min_damage, max_damage)
	if damage > 0:
		communication("HURT (" + str(damage) + ")")
		life = life - damage 
		if life < 0: life = 0	
		status.hurt = true

func CombatCalculation(delta):
	if $CombatArea:
		if $CombatArea.has_overlapping_bodies() and $CombatArea.get_overlapping_bodies().size() > 1:
			if not inCoolDownAttack:
				for unitInArea in $CombatArea.get_overlapping_bodies():
					if unitInArea.faction != faction:
						inCoolDownAttack = true
						unitInArea.takeDamage(min_damage_given, max_damage_given)
						coolDownTimer.start()
						communication("ATTACK")
						status.attacking = true
				

func AnimationCalculation(delta):
	
	if life == 0:
		animation_selected = "die"
	elif status.hurt:
		animation_selected = "hurt"
	elif status.attacking:
		animation_selected = "shoot"
	elif speed > 0:
		animation_selected = "walk"
	else:
		animation_selected = "idle"
	
	if velocity.x > 0: 
		animation_flip = false
	elif velocity.x < 0:
		animation_flip = true
		
	$AnimatedSprite2D.play(animation_selected)
	
	pass
	
func MovementLoop(delta):
	# Gestionamos velocidad
		
	if status.moving == false:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed

	# Determinamos hacia donde vamos.
	velocity = global_position.direction_to(destination) * speed
	# Calculamos la direccion del movimiento
	move_direction = rad_to_deg(destination.angle_to_point(global_position))
	
	# Resolvemos el movimiento
	if global_position.distance_to(destination) < 5: # Estamos lo suficientemente cerca
		status.moving = false
	if global_position.distance_to(last_position) < 0.2 and status.moving:
		status.moving = false
	elif status.moving:
		last_position = global_position
	
	if life > 0 and not inCoolDownAttack:
		move_and_slide()
	
func StatusCalculation(delta):
	if life == 0:
		status.moving = false
		var deathTimer = Timer.new()
		add_child(deathTimer)
		deathTimer.autostart = true
		deathTimer.wait_time = 1.0
		deathTimer.one_shot = true
		deathTimer.timeout.connect(destroy_character)
		deathTimer.start()

func destroy_character():
	queue_free()

func _on_cool_down_timer_timeout():
	if inCoolDownAttack:
		inCoolDownAttack = false

func init():
	rng = RandomNumberGenerator.new()
	coolDownTimer = Timer.new()
	add_child(coolDownTimer)
	coolDownTimer.autostart = true
	coolDownTimer.wait_time = coolDownAttackTime
	coolDownTimer.one_shot = true
	coolDownTimer.timeout.connect(_on_cool_down_timer_timeout)
	pass

func _physics_process(delta):
	MovementLoop(delta)
	
func _process(delta):
	comLabelString = ""
	StatusCalculation(delta)
	AnimationCalculation(delta)
	CombatCalculation(delta)
	ComunicationCalculation(delta)
	
func ComunicationCalculation(delta):
	#if (comLabelString != ""):
		#$ComLabel.text = comLabelString
		#$ComLabel.show()
	$LifeLabel.text = str(life)
	$LifeLabel.show()
	
func communication(message):
	comLabelString += message + " " 
	
func _ready():
	init()

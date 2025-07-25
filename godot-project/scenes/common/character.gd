extends CharacterBody2D
class_name Character

@export var faction = ""
@export var max_speed = 200
@export var speed = 0
@export var acceleration = 1200
@export var life = 10
@export var coolDownAttackTime = 1.0
@export var min_damage_given = 1
@export var max_damage_given = 1
@export var unit_type = 'default'
@export var input_accepted = false
@export var attack_block_movement = false
@export var show_progress_bar = false
@export var bullet_speed = 150
@export var bullet_lifetime = 1
@export var invincible = false
@export var last_input = Vector2.ZERO
@export var flipped = false
@export var iAttackProbability = 100
@export var gunsound_type = 'mosquete'
@export var just_idle = false
@export var aim_calculated = true

var barrilete_cosmico = false
var last_general_direction = Vector2.ZERO
var drop_reward  = false
var original_z_index = 0
var bCalculoDireccion = true
var oGoalAssigned = null
var hasToAttack = false

var experience_given = 1

var input_direction
var move_direction
var calculated_direction
var rng
@onready var animation_tree : AnimationTree = $AnimationTree

var status = {"moving": false, "attacking": false, "hurt": false}
var death_emited = false
var attack_objective = null
var destination = Vector2()
var movement = Vector2()
var animation_flip = false
var selected = false
var last_position = Vector2.ZERO
var inCoolDownAttack = false
var coolDownTimer = null
var deathTimer = null

var pulseDirectionTimer = null

var comLabelString = ""
var vMouseInitialPosition = Vector2.ZERO

var aGunshotsSounds = [
	preload("res://assets/original/sounds/mosquetes/gunshot01.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot02.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot03.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot04.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot05.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot06.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot07.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot08.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot09.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot10.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot11.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot12.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot13.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot14.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot15.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot16.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot17.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot18.mp3"),
	preload("res://assets/original/sounds/mosquetes/gunshot19.mp3")
]


var aEscopetaSounds = [
	preload("res://assets/original/sounds/escopeta/escopeta_01.mp3"),
	preload("res://assets/original/sounds/escopeta/escopeta_02.mp3"),
	preload("res://assets/original/sounds/escopeta/escopeta_03.mp3"),
	preload("res://assets/original/sounds/escopeta/escopeta_04.mp3"),
	preload("res://assets/original/sounds/escopeta/escopeta_05.mp3"),
	preload("res://assets/original/sounds/escopeta/escopeta_06.mp3")
]
		
#func animation_ends(animation):
#	print(animation)
#	if animation == 'die'
#		animation_tree.active = false

func add_to_faction(new_faction):
	faction = new_faction
	add_to_group("faccion_" + faction)
	add_to_group("faccion_" + faction + "_" + unit_type)

func go_to(new_destination, forced = false):
	if selected or forced:
		status.moving = true
		destination = new_destination
		if has_node("SelectionArea"):
			$SelectionArea.set_selected(false)
			
			
func get_input():
	var direction = Vector2.ZERO
	if input_accepted:
		direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

		if Input.is_action_just_pressed("Click"):
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			vMouseInitialPosition = get_global_mouse_position()
		if Input.is_action_just_released("Click"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
		if Input.is_action_pressed("Click"):
			var vMousePosition = get_global_mouse_position()
			direction = (vMousePosition - vMouseInitialPosition)
			if direction.distance_to(Vector2.ZERO) < 15:
				direction = Vector2.ZERO
			
		
			
		
	return direction.normalized()

func TakeDamage(min_damage, max_damage):
	var damage = rng.randi_range(min_damage, max_damage)
	if damage > 0:
		communication("-" + str(damage) + "")
		life = life - damage 
		if life < 0: life = 0	
		status.hurt = true
		hurt()

func hurt():
	status.hurt = false
	pass
	
func walk():
	pass
	
func idle():
	pass

func CombatCalculation(_delta):
	if life > 0:
		if aim_calculated and not inCoolDownAttack and $CombatArea.has_overlapping_bodies():
			var aBodies = $CombatArea.get_overlapping_bodies()
			if aBodies.size() > 0:
				if not inCoolDownAttack:
					var attacked = false
					status.attacking = false
					for unitInArea in aBodies:
						if ("faction" in unitInArea) and unitInArea.faction != faction and not attacked and unitInArea.life > 0:
							inCoolDownAttack = true
							var startAttack = true
							if iAttackProbability < 100:
								var iAttackValue = rng.randi_range(0, 99)
								startAttack = iAttackValue < iAttackProbability
								
							if startAttack:
								
								#unitInArea.takeDamage(min_damage_given, max_damage_given)
								attack_objective = {"global_position": unitInArea.global_position, "faction": unitInArea.faction, "velocity": unitInArea.velocity}
								coolDownTimer.start()
								status.attacking = true
								attacked = true
								continue
					
				else:
					var enemiesInArea = 0
					for unitInArea in aBodies:
						if ("faction" in unitInArea) and unitInArea.faction != faction:
							enemiesInArea += 1
							continue
					if enemiesInArea == 0:
						status.attacking = false
		elif not aim_calculated and not inCoolDownAttack:
			var startAttack = true
			if iAttackProbability < 100:
				var iAttackValue = rng.randi_range(0, 99)
				startAttack = iAttackValue < iAttackProbability
								
			if startAttack:
				inCoolDownAttack = true
				coolDownTimer.start()
				status.attacking = true
				hasToAttack = true
		
		if status.attacking and attack_block_movement:
			status.moving = true

func AnimationCalculation(_delta):
	
	if life == 0:
		animation_tree["parameters/conditions/die"] = true
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/got_hurt"] = false
		animation_tree["parameters/conditions/shooting"] = false
		animation_tree["parameters/conditions/walking"] = false
		if "parameters/conditions/barrilete_cosmico" in animation_tree:
			animation_tree["parameters/conditions/barrilete_cosmico"] = false
	elif barrilete_cosmico:
		animation_tree["parameters/conditions/die"] = false
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/got_hurt"] = false
		animation_tree["parameters/conditions/shooting"] = false
		animation_tree["parameters/conditions/walking"] = false
		if "parameters/conditions/barrilete_cosmico" in animation_tree:
			animation_tree["parameters/conditions/barrilete_cosmico"] = true
	elif status.hurt:
		animation_tree["parameters/conditions/die"] = false
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/got_hurt"] = true
		animation_tree["parameters/conditions/shooting"] = false
		animation_tree["parameters/conditions/walking"] = false
		if "parameters/conditions/barrilete_cosmico" in animation_tree:
			animation_tree["parameters/conditions/barrilete_cosmico"] = false
	elif status.attacking:
		animation_tree["parameters/conditions/die"] = false
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/got_hurt"] = false
		animation_tree["parameters/conditions/shooting"] = false
		animation_tree["parameters/conditions/walking"] = true
		if "parameters/conditions/barrilete_cosmico" in animation_tree:
			animation_tree["parameters/conditions/barrilete_cosmico"] = false
	elif status.moving:
		animation_tree["parameters/conditions/die"] = false
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/got_hurt"] = false
		animation_tree["parameters/conditions/shooting"] = false
		animation_tree["parameters/conditions/walking"] = true
		if "parameters/conditions/barrilete_cosmico" in animation_tree:
			animation_tree["parameters/conditions/barrilete_cosmico"] = false
		walk()
	else:
		idle()
		animation_tree["parameters/conditions/die"] = false
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/got_hurt"] = false
		animation_tree["parameters/conditions/shooting"] = false
		animation_tree["parameters/conditions/walking"] = false
		if "parameters/conditions/barrilete_cosmico" in animation_tree:
			animation_tree["parameters/conditions/barrilete_cosmico"] = false
		
	if velocity.x > 0: 
		$AnimatedSprite2D.flip_h = false
		#scale = Vector2(1.0, 1.0)
	elif velocity.x < 0:
		#scale = Vector2(-1.0, 1.0)
		$AnimatedSprite2D.flip_h = true	
	
	#flipped = $AnimatedSprite2D.flip_h
	if just_idle and flipped:
		$AnimatedSprite2D.flip_h = flipped
		#scale = Vector2(-1.0, 1.0)
		
		
	
	
func MovementLoop(delta):
	# Gestionamos velocidad
	if Engine.time_scale == 0:
		return 
	
	if status.moving == false and not input_accepted:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	

	if not input_accepted:
		# Determinamos hacia donde vamos.
		# Resolvemos el movimiento
		if bCalculoDireccion:
			calculated_direction = global_position.direction_to(destination)
			if global_position.distance_to(destination) < 5: # Estamos lo suficientemente cerca
				status.moving = false
			if global_position.distance_to(last_position) < 0.2 and status.moving:
				status.moving = false
			elif status.moving:
				last_position = global_position
			bCalculoDireccion = false
		velocity = calculated_direction * speed	
		
	else:
		var input = get_input();
		#print(input)
		velocity = input * speed
		status.moving = false
		if input != Vector2.ZERO: 
			status.moving = true
			last_input = input
	
	var can_move = life > 0 #and not status.attacking
	
	if can_move or input_accepted:
		move_and_slide()
	
func StatusCalculation(_delta):
	if life == 0:
		status.moving = false
		status.attacking = false
		#("Death", faction)
		
		deathTimer = Timer.new()
		add_child(deathTimer)
		deathTimer.autostart = true
		deathTimer.wait_time = 5
		deathTimer.one_shot = true
		deathTimer.timeout.connect(destroy_character)
		deathTimer.start()
		
		
		if drop_reward:
			drop_the_reward(experience_given)
			

func drop_the_reward(_experience_given):
	pass

func destroy_character():
	#print("DESTROY", self)
	queue_free()

func _on_cool_down_timer_timeout():
	if inCoolDownAttack:
		inCoolDownAttack = false
		status.attacking = false

func _on_pulse_direction_timer_timeout():
	bCalculoDireccion = true		

func init():
	rng = RandomNumberGenerator.new()
	if has_node("LifeProgress"):
		$LifeProgress.max_value = life
		if show_progress_bar:
			$LifeProgress.show()
	coolDownTimer = Timer.new()
	add_child(coolDownTimer)
	coolDownTimer.autostart = true
	coolDownTimer.wait_time = coolDownAttackTime
	coolDownTimer.one_shot = true
	coolDownTimer.timeout.connect(_on_cool_down_timer_timeout)
	
	pulseDirectionTimer = Timer.new()
	add_child(pulseDirectionTimer)
	pulseDirectionTimer.autostart = true
	pulseDirectionTimer.wait_time = 0.1
	if faction == 'ingleses':
		pulseDirectionTimer.wait_time = 3
	pulseDirectionTimer.one_shot = false
	pulseDirectionTimer.timeout.connect(_on_pulse_direction_timer_timeout)
	pass

func _physics_process(delta):
	if life > 0:
		MovementLoop(delta)
	
func _process(delta):
	comLabelString = ""
	
	StatusCalculation(delta)
	if life > 0:
		#if faction != "ingleses": 
		CombatCalculation(delta)
		#ComunicationCalculation(delta)
	AnimationCalculation(delta)
	
func ComunicationCalculation(_delta):
	#if (comLabelString != ""):
		#$ComLabel.text = comLabelString
		#$ComLabel.show()	
	#$LifeLabel.text = str(life)
	#$LifeLabel.show()
	#if has_node("LifeProgress"):
	#	$LifeProgress.value = life
	pass
	
	
func communication(message):
	comLabelString += message + " " 
	$ComLabel.modulate.a = 1
	$ComLabel.text = comLabelString
	
	#var tween := create_tween()
	#tween.tween_property($ComLabel, "modulate:a", 1, 0.25)
	await get_tree().create_timer(0.25).timeout
	$ComLabel.modulate.a = 0
	#tween.tween_property($ComLabel, "modulate:a", 0, 0.25)
	#await tween.finished
	
	$ComLabel.text = ""
	
	
func set_last_general_direction(oDirection):
	last_general_direction = oDirection
	
func attack_sound(stream):
	var aGunSounds = aGunshotsSounds
	if gunsound_type == "escopeta": 
		aGunSounds = aEscopetaSounds
	var iGunshotKey = rng.randi_range(0, aGunSounds.size()-1)
	stream = aGunSounds[iGunshotKey]
	
	AudioStreamManager.play({"stream": stream, "volume": null, "pitch": null})
	
func malon_sticked():
	if just_idle: return 
	var bSticked = false
	
	if $MalonArea and $MalonArea.has_overlapping_bodies():
		var aBodies = $MalonArea.get_overlapping_bodies()
		if aBodies.size() > 1:
			for unitInArea in aBodies:
				if ("faction" in unitInArea) and unitInArea.faction == faction:
					bSticked = true
					continue
					
	input_accepted = false
	#print("DISTANCIA",  global_position.distance_to(oGoalAssigned.global_position))
	if (not bSticked and oGoalAssigned) or (oGoalAssigned and global_position.distance_to(oGoalAssigned.global_position) > 50):
		if global_position.distance_to(oGoalAssigned.global_position) > 50:
			go_to(oGoalAssigned.global_position, true)
	#else:
		#input_accepted = true
	
func _ready():
#	if has_node("AnimationPlayer"):
#		print($AnimationPlayer.animation_finished)
#		$AnimationPlayer.animation_finished.connect(animation_ends)
	init()

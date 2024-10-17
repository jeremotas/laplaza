extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
#var barrilete_cosmico = false
var barrileteTimer = null
@export var agua_hirviendo_power = 0
var max_life = 0

const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "general"
	min_damage_given = Global.settings.patricios.general.attack.min_damage_given
	max_damage_given = Global.settings.patricios.general.attack.max_damage_given
	max_speed = Global.settings.patricios.general.max_speed
	life = Global.settings.patricios.general.life
	max_life = life
	bullet_speed = Global.settings.patricios.general.attack.bullet.speed
	bullet_lifetime = Global.settings.patricios.general.attack.bullet.duration
	coolDownAttackTime = Global.settings.patricios.general.attack.cooldown
	invincible = false
	agua_hirviendo_power = 0
	
	init()

func ready():
	input_accepted = false	
	
func _process(delta):
	last_direction_message()
	attack()
	invincible_effect()
	life_status()
	super(delta)

func celebration():
	animation_tree["parameters/conditions/die"] = false
	animation_tree["parameters/conditions/idle"] = false
	animation_tree["parameters/conditions/got_hurt"] = false
	animation_tree["parameters/conditions/shooting"] = false
	animation_tree["parameters/conditions/walking"] = false
	animation_tree["parameters/conditions/barrilete_cosmico"] = false	
	animation_tree["parameters/conditions/win"] = true	
	
func life_status():
	
	if not status.hurt:
		
		if life <= Global.settings.game.player_warning_life and life > 0:
			$AnimatedSprite2D.material.set_shader_parameter("width",1.0)
		else:
			$AnimatedSprite2D.material.set_shader_parameter("width",0.0)

func invincible_effect():
	$InvincibleEffect.visible = invincible
	
func activate_agua_hirviendo_level_up():
	agua_hirviendo_power += 1
	$AguaHirviendoTimer.stop()
	$AguaHirviendoTimer.wait_time = Global.settings.patricios.general.agua_hirviendo.cooldown - Global.settings.patricios.general.agua_hirviendo.time_reduce_step * agua_hirviendo_power
	$AguaHirviendoTimer.start()

func last_direction_message():
	get_tree().call_group("faccion_patricios", "set_last_general_direction", last_input)

func attack():
	if attack_objective:
		var b = bullet.instantiate()
		if has_node("WeaponPoint"):
			b.global_position = $WeaponPoint.global_position
			b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
			b.objective_faction = attack_objective.faction
			b.min_damage = min_damage_given
			b.max_damage = max_damage_given
			b.speed = bullet_speed
			b.bullet_lifetime = bullet_lifetime
			b.set_collision_mask(2)
			b.set_color(Color(1, 1, 1))
			#if barrilete_cosmico:
				#b.prepare_explotion(2, Global.settings.patricios.general.barrilete_cosmico.bullet.explotion.duration, Global.settings.patricios.general.barrilete_cosmico.bullet.explotion.scale, Global.settings.patricios.general.barrilete_cosmico.bullet.explotion.particle)
				#b.set_color(Color(1,1,1,0.01))
			
			
			if not barrilete_cosmico:
				get_parent().add_child(b)
				attack_sound(GUNSHOT)
		
		attack_objective = null
	pass	
	
func init_barrilete_cosmico():
	barrilete_cosmico = true
	get_parent().ActualTimeScale = 0.2
	Engine.time_scale = 0.2
	#min_damage_given = Global.settings.patricios.general.barrilete_cosmico.min_damage_given
	#max_damage_given = Global.settings.patricios.general.barrilete_cosmico.max_damage_given
	max_speed = Global.settings.patricios.general.barrilete_cosmico.max_speed
	#bullet_lifetime = Global.settings.patricios.general.barrilete_cosmico.bullet.duration
	#bullet_speed = Global.settings.patricios.general.barrilete_cosmico.bullet.speed
	#coolDownAttackTime = Global.settings.patricios.general.barrilete_cosmico.cooldown
	$BarrileteCosmico.set_collision_mask_value(2, true)
	status.attacking = true
	invincible = true
	
	
	# Determino cuanto dura el barrilete cosmico
	barrileteTimer = Timer.new()
	add_child(barrileteTimer)
	barrileteTimer.autostart = true
	barrileteTimer.wait_time = Global.settings.patricios.general.barrilete_cosmico.duration
	barrileteTimer.one_shot = true
	barrileteTimer.timeout.connect(end_barrilete_cosmico)
	barrileteTimer.start()
	#get_parent().stop_music()
	
	$RelatoVictorHugo.play()

func pause():
	if barrilete_cosmico:
		$RelatoVictorHugo.stream_paused = true
	
func unpause():
	if barrilete_cosmico:
		$RelatoVictorHugo.stream_paused = false
		get_parent().ActualTimeScale = 0.2
		Engine.time_scale = 0.2
	
func end_barrilete_cosmico():
	life = Global.settings.patricios.general.life
	max_speed = Global.settings.patricios.general.max_speed
	min_damage_given = Global.settings.patricios.general.attack.min_damage_given
	max_damage_given = Global.settings.patricios.general.attack.max_damage_given
	bullet_speed = Global.settings.patricios.general.attack.bullet.speed
	bullet_lifetime = Global.settings.patricios.general.attack.bullet.duration
	coolDownAttackTime = Global.settings.patricios.general.attack.cooldown
	$BarrileteCosmico.set_collision_mask_value(2, false)
	invincible = false
	barrilete_cosmico = false
	$RelatoVictorHugo.stop()
	#get_parent().start_music()
	Engine.time_scale = 1
	AnimationCalculation(0)
	pass
	
func walk():
	if not barrilete_cosmico:
		$WalkSound.volume_db = -1
	else:
		$WalkSound.volume_db = -100
	
func idle():
	$WalkSound.volume_db = -100

func hurt():
	$HurtSound.play()
	$AnimatedSprite2D.material.set_shader_parameter("width",1.0)
	await get_tree().create_timer(0.4).timeout
	$AnimatedSprite2D.material.set_shader_parameter("width",0.0)
	status.hurt = false

# Funciones para poder seleccionarlo.
func show_selection():
	if selected:
		$AnimatedSprite2D.material.set_shader_parameter("width", 1.0)
	else:
		$AnimatedSprite2D.material.set_shader_parameter("width", 0.0)
		
#func _on_selection_area_selection_toggled(selection):
#	selected = selection
#	show_selection()


func _on_barrilete_cosmico_body_entered(body):
	if body and ("faction" in body) and body.faction == 'ingleses' and body.life > 0 and not body.invincible:
		if body.has_method("TakeDamage"):
			body.TakeDamage(10000, 10000)


func _on_agua_hirviendo_timer_timeout():
	if agua_hirviendo_power > 0:
		var b = bullet.instantiate()
		b.global_position = $WeaponPoint.global_position
		var yRandom = 0
		var xRandom = rng.randi_range(0,1)
		if yRandom == 0: yRandom = -1
		if xRandom == 0: xRandom = -1
		b.global_position.y = b.global_position.y + 240 * yRandom
		b.global_position.x = b.global_position.x + 300 * xRandom
		
		b.direction = b.global_position.direction_to($WeaponPoint.global_position + last_input * 150)
		b.objective_faction = 'ingleses'
		b.min_damage = Global.settings.patricios.general.agua_hirviendo.min_damage_given
		b.max_damage = Global.settings.patricios.general.agua_hirviendo.max_damage_given
		b.speed = Global.settings.patricios.general.agua_hirviendo.bullet.speed
		b.bullet_lifetime = Global.settings.patricios.general.agua_hirviendo.bullet.duration
		b.prepare_explotion(2, Global.settings.patricios.general.agua_hirviendo.bullet.explotion.duration, Global.settings.patricios.general.agua_hirviendo.bullet.explotion.scale, Global.settings.patricios.general.agua_hirviendo.bullet.explotion.particle, false)
		b.set_collision_mask(2)
		b.set_sprite("res://assets/created/ollami_32.png", 0.99, 4)
		b.set_color(Color(1, 1, 1))
		get_parent().add_child(b)


func _on_aspiradora_de_lagrimas_body_entered(body):
	
	if "unit_type" in body and body.unit_type == 'lagrima':
		body.follow(self)

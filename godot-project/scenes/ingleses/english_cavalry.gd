extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn") 
var lagrima = preload("res://scenes/common/lagrima.tscn") 
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

var speed_attack = 0
var attack_duration = 1.0
var trampling = false
var oEnemyToFollow = null
var chill_speed = 0.0

func _init():
	unit_type = "english_cavalry"
	max_speed = Global.settings.ingleses.english_cavalry.max_speed
	chill_speed = Global.settings.ingleses.english_cavalry.max_speed
	life = Global.settings.ingleses.english_cavalry.life
	experience_given = Global.settings.ingleses.english_cavalry.experience_given
	min_damage_given = Global.settings.ingleses.english_cavalry.attack.min_damage_given
	max_damage_given = Global.settings.ingleses.english_cavalry.attack.max_damage_given
	speed_attack = Global.settings.ingleses.english_cavalry.attack.trample.speed
	attack_duration = Global.settings.ingleses.english_cavalry.attack.trample.duration
	coolDownAttackTime = Global.settings.ingleses.english_cavalry.attack.cooldown
	drop_reward = true
	
	
	init()
	
func _ready():
	$TrampleTimer.wait_time = attack_duration
	super()
	
func set_enemy_to_follow():
	var aEnemyToFollow = get_tree().get_nodes_in_group("general_group")
	if aEnemyToFollow.size() == 1:
		oEnemyToFollow = aEnemyToFollow[0]

func _process(delta):
	set_enemy_to_follow()
	attack()
	super(delta)
	

func drop_the_reward(experience_given_value):
	drop_reward = false
	var l = lagrima.instantiate()
	l.modulate = Color(1,0,0,1)
	l.scale = Vector2(1.5,1.5)
	l.experience_given = experience_given_value
	l.global_position = global_position
	get_parent().add_child(l)

func attack():
	if oEnemyToFollow:
		destination  = oEnemyToFollow.global_position
		attack_objective = {"global_position": destination, "faction": "patricios", "velocity": 0}
		if not inCoolDownAttack:
			trampling = true
			max_speed = speed_attack
			inCoolDownAttack = true
			coolDownTimer.start()
			$TrampleTimer.start()
		elif not trampling:
			max_speed = chill_speed
	
	if trampling:
		var oEnemiesToTrample = $AreaDeAtaque.get_overlapping_bodies()
		for enemy in oEnemiesToTrample:
			enemy.TakeDamage(min_damage_given, max_damage_given)
		

#func _on_area_de_ataque_body_entered(body: Node2D) -> void:
#	if trampling:
		#body.TakeDamage(min_damage_given, max_damage_given)

func _on_trample_timer_timeout() -> void:
	trampling = false

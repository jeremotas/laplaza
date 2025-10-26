extends Character

@onready var animation = $AnimatedSprite2D


var lagrima = preload("res://scenes/common/lagrima.tscn") 
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")
var bullet = preload("res://scenes/common/bullet.tscn") 	
var iAttacksMade = 0
var aAttackAngles = [0.0]
var iAttacksInitialRotation = 0
var bShuffleAngles = true
var sAttackObjective = "destino"
var oEnemyToFollow = null

func _init():
	unit_type = "ingles"
	
	max_speed = Global.settings.ingleses.soldado.max_speed
	life = Global.settings.ingleses.soldado.life
	min_damage_given = Global.settings.ingleses.soldado.attack.min_damage_given
	max_damage_given = Global.settings.ingleses.soldado.attack.max_damage_given
	experience_given = Global.settings.ingleses.soldado.experience_given
	bullet_speed = Global.settings.ingleses.soldado.attack.bullet.speed
	bullet_lifetime = Global.settings.ingleses.soldado.attack.bullet.duration
	coolDownAttackTime = Global.settings.ingleses.soldado.attack.cooldown
	iAttackProbability = Global.settings.ingleses.soldado.attack.probability
	bShuffleAngles = Global.settings.ingleses.soldado.attack.shuffle_angles
	aAttackAngles  = Global.settings.ingleses.soldado.attack.angles
	sAttackObjective = Global.settings.ingleses.soldado.attack.objective
	drop_reward = true
	init()
	
func _ready():
	set_enemy_to_follow()
	if bShuffleAngles:
		aAttackAngles.shuffle()
	super()

func _process(delta):
	attack()
	super(delta)

	
func set_enemy_to_follow():
	var aEnemyToFollow = get_tree().get_nodes_in_group("general_group")
	if aEnemyToFollow.size() == 1:
		oEnemyToFollow = aEnemyToFollow[0]

func drop_the_reward(experience_given_value):
	drop_reward = false
	var l = lagrima.instantiate()
	l.experience_given = experience_given_value
	l.global_position = global_position
	get_parent().add_child(l)

func attack():
	var attack_position = destination
	if sAttackObjective == 'General' and oEnemyToFollow != null:
		attack_position = oEnemyToFollow.global_position
	
	attack_objective = {"global_position": attack_position, "faction": "patricios", "velocity": 0}
	
	if hasToAttack and attack_objective.global_position != Vector2.ZERO and $VisibleOnScreenNotifier2D.is_on_screen() and not blocked_attack:
		
		var b = bullet.instantiate()
		b.global_position = $WeaponPoint.global_position
		b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
		
		var iDistortionAngle = (iAttacksMade) % aAttackAngles.size()
		var fAngle = aAttackAngles[iDistortionAngle]
		var fDistortionAngle = deg_to_rad(fAngle)
		b.direction = b.direction.rotated(fDistortionAngle)
		
		b.objective_faction = attack_objective.faction
		b.min_damage = min_damage_given
		b.max_damage = max_damage_given
		b.speed = bullet_speed
		b.bullet_lifetime = bullet_lifetime
		b.set_collision_mask_bullet(1)
		b.set_collision_mask_bullet(4)
		b.set_color(Color(1, 1, 0.2))
		get_parent().add_child(b)

		attack_sound(GUNSHOT)
		iAttacksMade += 1
	hasToAttack = false

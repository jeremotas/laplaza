extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn") 
var lagrima = preload("res://scenes/common/lagrima.tscn") 
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")
var oEnemyToFollow = null

func _init():
	unit_type = "ingles"
	max_speed = Global.settings.ingleses.cannon.max_speed
	life = Global.settings.ingleses.cannon.life
	min_damage_given = Global.settings.ingleses.cannon.attack.min_damage_given
	max_damage_given = Global.settings.ingleses.cannon.attack.max_damage_given
	experience_given = Global.settings.ingleses.cannon.experience_given
	bullet_speed = Global.settings.ingleses.cannon.attack.bullet.speed
	bullet_lifetime = Global.settings.ingleses.cannon.attack.bullet.duration
	coolDownAttackTime = Global.settings.ingleses.cannon.attack.cooldown
	iAttackProbability = Global.settings.ingleses.cannon.attack.probability
	drop_reward = true
	init()
	random_scale()
	
func random_scale():
	if (Global.settings.ingleses.cannon.scale_probability > 0):
		var iProb = rng.randi_range(0, 100)
		if (iProb < Global.settings.ingleses.cannon.scale_probability):
			var fScale = rng.randf_range(1.1, 2.0)
			scale = Vector2(fScale, fScale)
			life = life * fScale
			experience_given = ceil(experience_given * fScale)
	
func _ready():
	set_enemy_to_follow()
	super()

func _process(delta):
	attack()
	super(delta)
	

func drop_the_reward(experience_given_value):
	drop_reward = false
	var l = lagrima.instantiate()
	l.modulate = Color(1,0,0,1)
	#l.scale = Vector2(1.5,1.5)
	l.experience_given = experience_given_value
	l.global_position = global_position
	get_parent().add_child(l)
	
func set_enemy_to_follow():
	var aEnemyToFollow = get_tree().get_nodes_in_group("general_group")
	if aEnemyToFollow.size() == 1:
		oEnemyToFollow = aEnemyToFollow[0]

func attack():
	
	attack_objective = {"global_position": oEnemyToFollow.global_position, "faction": "patricios", "velocity": 0}
	if hasToAttack and attack_objective.global_position != Vector2.ZERO and $VisibleOnScreenNotifier2D.is_on_screen() and not blocked_attack:
		var b = bullet.instantiate()
		b.global_position = $WeaponPoint.global_position
		b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
		var fDistortion = rng.randf_range(-0.1, 0.1)
		b.direction.x += fDistortion
		b.objective_faction = attack_objective.faction
		b.min_damage = min_damage_given
		b.max_damage = max_damage_given
		b.speed = bullet_speed
		b.bullet_lifetime = bullet_lifetime
		#b.set_sprite("", 1.1, 0)
		b.set_collision_mask_bullet(1)
		b.set_collision_mask_bullet(4)
		b.set_color(Color(1, 0.1, 0.1))
		b.set_scale(Vector2(3.0, 3.0))
		
		b.prepare_explotion(2, Global.settings.ingleses.cannon.attack.bullet.explotion.duration, Global.settings.ingleses.cannon.attack.bullet.explotion.scale, Global.settings.ingleses.cannon.attack.bullet.explotion.particle)
		
		get_parent().add_child(b)
		
		#$WeaponSound.play()
		attack_sound(GUNSHOT)
		
		
	hasToAttack = false
	pass	

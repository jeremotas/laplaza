extends Character

@onready var animation = $AnimatedSprite2D


var lagrima = preload("res://scenes/common/lagrima.tscn") 
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")
var bullet = preload("res://scenes/common/bullet.tscn") 	

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
	drop_reward = true
	init()
	
func _ready():
	super()

func _process(delta):
	attack()
	super(delta)
	

func drop_the_reward(experience_given_value):
	drop_reward = false
	var l = lagrima.instantiate()
	l.experience_given = experience_given_value
	l.global_position = global_position
	get_parent().add_child(l)

func attack():
	attack_objective = {"global_position": destination, "faction": "patricios", "velocity": 0}
	if hasToAttack and attack_objective.global_position != Vector2.ZERO and $VisibleOnScreenNotifier2D.is_on_screen():
		
		var b = bullet.instantiate()
		b.global_position = $WeaponPoint.global_position
		b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
		var fDistortion = rng.randf_range(-0.1, 0.1) #minima distorsion de disparo
		b.direction.x += fDistortion
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
			
	hasToAttack = false
	pass	

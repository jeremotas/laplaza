extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn") 
var lagrima = preload("res://scenes/common/lagrima.tscn") 
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "ingles"
	max_speed = Global.settings.ingleses.highlander.max_speed
	life = Global.settings.ingleses.highlander.life
	min_damage_given = Global.settings.ingleses.highlander.attack.min_damage_given
	max_damage_given = Global.settings.ingleses.highlander.attack.max_damage_given
	experience_given = Global.settings.ingleses.highlander.experience_given
	bullet_speed = Global.settings.ingleses.highlander.attack.bullet.speed
	bullet_lifetime = Global.settings.ingleses.highlander.attack.bullet.duration
	coolDownAttackTime = Global.settings.ingleses.highlander.attack.cooldown
	iAttackProbability = Global.settings.ingleses.highlander.attack.probability
	drop_reward = true
	init()
	random_scale()
	
func random_scale():
	if (Global.settings.ingleses.highlander.scale_probability > 0):
		var iProb = rng.randi_range(0, 100)
		if (iProb < Global.settings.ingleses.highlander.scale_probability):
			var fScale = rng.randf_range(1.1, 2)
			scale = Vector2(fScale, fScale)
			life = life * fScale
			experience_given = ceil(experience_given * fScale)
	
func _ready():
	super()

func _process(delta):
	attack()
	super(delta)
	

func drop_the_reward(experience_given_value):
	drop_reward = false
	var l = lagrima.instantiate()
	l.modulate = Color(1,0,1,1)
	l.scale = Vector2(1.5,1.5)
	l.experience_given = experience_given_value
	l.global_position = global_position
	get_parent().add_child(l)

func attack():
	if attack_objective:
		var b = bullet.instantiate()
		b.global_position = $WeaponPoint.global_position
		b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
		b.objective_faction = attack_objective.faction
		b.min_damage = min_damage_given
		b.max_damage = max_damage_given
		b.speed = bullet_speed
		b.bullet_lifetime = bullet_lifetime
		b.set_collision_mask(1)
		b.set_collision_mask(4)
		b.set_color(Color(1, 1, 0.2))
		get_parent().add_child(b)
		
		#$WeaponSound.play()
		attack_sound(GUNSHOT)
		
		
		attack_objective = null
	pass	

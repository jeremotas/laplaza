extends Character

@onready var animation = $AnimatedSprite2D


var lagrima = preload("res://scenes/common/lagrima.tscn") 
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")
var bullet = preload("res://scenes/common/bullet.tscn") 	
var exploded = false

func _init():
	unit_type = "zapador"
	
	max_speed = Global.settings.ingleses.zapador.max_speed
	life = Global.settings.ingleses.zapador.life
	min_damage_given = Global.settings.ingleses.zapador.attack.min_damage_given
	max_damage_given = Global.settings.ingleses.zapador.attack.max_damage_given
	experience_given = Global.settings.ingleses.zapador.experience_given
	bullet_speed = Global.settings.ingleses.zapador.attack.bullet.speed
	bullet_lifetime = Global.settings.ingleses.zapador.attack.bullet.duration
	
	drop_reward = true
	init()
	
func _ready():
	exploded = false
	super()

func _process(delta):
	if life == 0:
		explode()
	super(delta)
	

func drop_the_reward(experience_given_value):
	drop_reward = false
	var l = lagrima.instantiate()
	l.experience_given = experience_given_value
	l.global_position = global_position
	get_parent().add_child(l)

func explode():
	$AnimatedSprite2D.material.set_shader_parameter("width",0.0)
	if not exploded:
		attack_objective = {"global_position": destination, "faction": "patricios", "velocity": 0}
		life = 0		
		exploded = true
		
		var b = bullet.instantiate()
		b.global_position = $WeaponPoint.global_position
		b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
		b.objective_faction = attack_objective.faction
		b.min_damage = min_damage_given
		b.max_damage = max_damage_given
		b.speed = bullet_speed
		b.bullet_lifetime = bullet_lifetime
		b.set_collision_mask_bullet(1)
		b.set_collision_mask_bullet(2)
		b.set_collision_mask_bullet(4)
		b.set_color(Color(1, 1, 0.2))
		get_parent().add_child(b)
		b.prepare_explotion(2, Global.settings.ingleses.zapador.attack.bullet.explotion.duration, Global.settings.ingleses.zapador.attack.bullet.explotion.scale, Global.settings.ingleses.zapador.attack.bullet.explotion.particle)

func prepare_explotion():
	$AnimatedSprite2D.material.set_shader_parameter("width",1.0)
	$ExplodeTimer.start()

func _on_enemy_detection_body_entered(body: Node2D) -> void:
	if body.life > 0:
		prepare_explotion()


func _on_timer_timeout() -> void:
	explode()

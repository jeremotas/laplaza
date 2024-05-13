extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn") 
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "ingles"
	
	max_speed = Global.settings.ingleses.soldado.max_speed
	life = Global.settings.ingleses.soldado.life
	min_damage_given = Global.settings.ingleses.soldado.min_damage_given
	max_damage_given = Global.settings.ingleses.soldado.max_damage_given
	experience_given = Global.settings.ingleses.soldado.experience_given
	bullet_speed = Global.settings.ingleses.soldado.bullet_speed
	coolDownAttackTime = Global.settings.patricios.granadero.cooldown_attack_time
	
func _ready():
	super()

func _process(delta):
	attack()
	super(delta)
	

func attack():
	if attack_objective:
		var b = bullet.instantiate()
		b.global_position = $WeaponPoint.global_position
		b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
		b.objective_faction = attack_objective.faction
		b.min_damage = min_damage_given
		b.max_damage = max_damage_given
		b.speed = bullet_speed
		b.set_collision_mask(1)
		b.set_color(Color(1, 1, 0.2))
		get_parent().add_child(b)
		
		#$WeaponSound.play()
		attack_sound(GUNSHOT)
		
		
		attack_objective = null
	pass	

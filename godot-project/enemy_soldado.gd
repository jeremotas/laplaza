extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://bullet.tscn") 

func _ready():
	max_speed = 20
	life = 5
	min_damage_given = 1
	max_damage_given = 1
	super()
	pass

func _process(delta):
	attack()
	super(delta)
	

func attack():
	if attack_objective:
		var b = bullet.instantiate()
		b.position = $WeaponPoint.position
		b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
		b.objective_faction = attack_objective.faction
		b.min_damage = min_damage_given
		b.max_damage = max_damage_given
		b.set_collision_mask(1)
		
		add_child(b)
		
		$WeaponSound.play()
		
		attack_objective = null
	pass	

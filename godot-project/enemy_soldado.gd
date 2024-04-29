extends Character

@onready var animation = $AnimatedSprite2D

func _ready():
	max_speed = 20
	life = 5
	min_damage_given = 2
	max_damage_given = 3
	init()
	pass

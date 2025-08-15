extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "granadero"
	min_damage_given = Global.settings.patricios.mignon.attack.min_damage_given
	max_damage_given = Global.settings.patricios.mignon.attack.max_damage_given
	max_speed = Global.settings.patricios.mignon.max_speed
	life = Global.settings.patricios.mignon.life
	bullet_speed = Global.settings.patricios.mignon.attack.bullet.speed
	bullet_lifetime = Global.settings.patricios.mignon.attack.bullet.duration
	coolDownAttackTime = Global.settings.patricios.mignon.attack.cooldown

	init()

func assign_goal(oGoal):
	oGoalAssigned = oGoal
	
	
func _process(delta):
	malon_sticked()
	attack()
	super(delta)

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
			b.set_collision_mask_bullet(2)
			b.set_color(Color(0.7, 0.7, 0.7))
			get_parent().add_child(b)
			
			attack_sound(GUNSHOT)
		#$WeaponSound.play()
		
		attack_objective = null
	pass	

# Funciones para poder seleccionarlo.
func show_selection():
	if selected:
		$AnimatedSprite2D.material.set_shader_parameter("width", 1.0)
	else:
		$AnimatedSprite2D.material.set_shader_parameter("width", 0.0)
		
#func _on_selection_area_selection_toggled(selection):
#	selected = selection
#	show_selection()

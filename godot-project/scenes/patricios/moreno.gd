extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "moreno"
	min_damage_given = Global.settings.patricios.moreno.attack.min_damage_given
	max_damage_given = Global.settings.patricios.moreno.attack.max_damage_given
	max_speed = Global.settings.patricios.moreno.max_speed
	life = Global.settings.patricios.moreno.life
	bullet_speed = Global.settings.patricios.moreno.attack.bullet.speed
	bullet_lifetime = Global.settings.patricios.moreno.attack.bullet.duration
	coolDownAttackTime = Global.settings.patricios.moreno.attack.cooldown

	init()

func assign_goal(oGoal):
	oGoalAssigned = oGoal
	
func _process(delta):
	malon_sticked()
	attack()
	super(delta)

func attack():
	if not inCoolDownAttack:
		inCoolDownAttack = true
		coolDownTimer.start()
		var b = bullet.instantiate()
		if has_node("WeaponPoint") and last_general_direction != Vector2.ZERO:
			b.global_position = $WeaponPoint.global_position
			
			if  last_general_direction.x < 0:
				b.global_position.x = $WeaponPoint.global_position.x - ($WeaponPoint.position.x  * 2)
			b.direction = last_general_direction #(attack_objective.global_position - $WeaponPoint.global_position).normalized()
			b.objective_faction = 'ingleses' #attack_objective.faction
			b.min_damage = min_damage_given
			b.max_damage = max_damage_given
			b.speed = bullet_speed
			b.bullet_lifetime = bullet_lifetime
			
			#b.set_collision_mask(2)
			b.prepare_explotion(2, Global.settings.patricios.moreno.attack.bullet.explotion.duration, Global.settings.patricios.moreno.attack.bullet.explotion.scale, Global.settings.patricios.moreno.attack.bullet.explotion.particle)
			b.set_color(Color(0.3,0.3,0.3))
			#b.set_color(Color(1, 1, 1, 0.2))
			get_parent().add_child(b)
			
			#attack_sound(GUNSHOT)
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

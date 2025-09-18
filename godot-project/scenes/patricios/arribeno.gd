extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "arribeno"
	min_damage_given = Global.settings.patricios.arribeno.attack.min_damage_given
	max_damage_given = Global.settings.patricios.arribeno.attack.max_damage_given
	max_speed = Global.settings.patricios.arribeno.max_speed
	life = Global.settings.patricios.arribeno.life
	bullet_speed = Global.settings.patricios.arribeno.attack.bullet.speed
	bullet_lifetime = Global.settings.patricios.arribeno.attack.bullet.duration
	coolDownAttackTime = Global.settings.patricios.arribeno.attack.cooldown

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
		#if  last_general_direction.x < 0:
			#b1.global_position.x = $WeaponPoint.global_position.x - ($WeaponPoint.position.x  * 2)
			
		var spread_angle = deg_to_rad(10) # separación entre balas
		var base_angle = last_general_direction.angle()

		for i in range(-2, 3): # genera 5 balas
			var bullet_instance = bullet.instantiate()
			bullet_instance.global_position = $WeaponPoint.global_position
			
			var angle = base_angle + (i * spread_angle)
			bullet_instance.direction = Vector2.RIGHT.rotated(angle) # dirección ajustada
			
			# Configuración general
			bullet_instance.objective_faction = "ingleses"
			bullet_instance.min_damage = min_damage_given
			bullet_instance.max_damage = max_damage_given
			bullet_instance.speed = bullet_speed
			bullet_instance.bullet_lifetime = bullet_lifetime
			bullet_instance.set_color(Color(0.8, 0.8, 0.8))
			bullet_instance.set_collision_mask_bullet(2)
			get_parent().add_child(bullet_instance)	
			
			attack_sound(GUNSHOT)
		#$WeaponSound.play()
		
		#attack_objective = null

# Funciones para poder seleccionarlo.
func show_selection():
	if selected:
		$AnimatedSprite2D.material.set_shader_parameter("width", 1.0)
	else:
		$AnimatedSprite2D.material.set_shader_parameter("width", 0.0)
		
#func _on_selection_area_selection_toggled(selection):
#	selected = selection
#	show_selection()

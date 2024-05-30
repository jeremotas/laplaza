extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "general"
	min_damage_given = Global.settings.patricios.general.min_damage_given
	max_damage_given = Global.settings.patricios.general.max_damage_given
	max_speed = Global.settings.patricios.general.max_speed
	life = Global.settings.patricios.general.life
	bullet_speed = Global.settings.patricios.general.bullet_speed
	coolDownAttackTime = Global.settings.patricios.general.cooldown_attack_time

	init()
	
func _process(delta):
	
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
			b.speed = Global.settings.patricios.general.bullet_speed
			b.set_collision_mask(2)
			b.set_color(Color(1, 1, 1))
			get_parent().add_child(b)
			
			attack_sound(GUNSHOT)
		#$WeaponSound.play()
		
		attack_objective = null
	pass	
	
func walk():
	$WalkSound.volume_db = -1
	
func idle():
	$WalkSound.volume_db = -100

func hurt():
	$HurtSound.play()
	modulate = Color("ff0000CC")
	await get_tree().create_timer(0.4).timeout
	modulate = Color("ffffffff")
	status.hurt = false

# Funciones para poder seleccionarlo.
func show_selection():
	if selected:
		$AnimatedSprite2D.material.set_shader_parameter("width", 1.0)
	else:
		$AnimatedSprite2D.material.set_shader_parameter("width", 0.0)
		
#func _on_selection_area_selection_toggled(selection):
#	selected = selection
#	show_selection()

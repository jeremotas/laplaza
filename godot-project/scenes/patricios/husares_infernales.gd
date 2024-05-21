extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")
var oGoal
var entered = false

func _init():
	unit_type = "husares_infernales"
	min_damage_given = Global.settings.patricios.husares_infernales.min_damage_given
	max_damage_given = Global.settings.patricios.husares_infernales.max_damage_given
	max_speed = Global.settings.patricios.husares_infernales.max_speed
	life = Global.settings.patricios.husares_infernales.life
	bullet_speed = Global.settings.patricios.husares_infernales.bullet_speed
	coolDownAttackTime = Global.settings.patricios.husares_infernales.cooldown_attack_time

	init()

func create_goal(endPosition):
	oGoal = Marker2D.new()
	oGoal.global_position = endPosition
	oGoalAssigned = oGoal

func assign_goal(oGoal):
	oGoalAssigned = oGoal
	
func _process(delta):
	#malon_sticked()
	attack()
	if speed == 0: queue_free()
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
			b.speed = Global.settings.patricios.husares_infernales.bullet_speed
			b.set_collision_mask(2)
			b.set_color(Color(1, 0, 0))
			get_parent().get_parent().add_child(b)
			
			#attack_sound(GUNSHOT)
		#$WeaponSound.play()
		
		attack_objective = null
	pass	

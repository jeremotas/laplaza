extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
const GUNSHOT = preload("res://assets/original/sounds/gunshot6.mp3")
var oGoal
var entered = false
var iShoots = 0

func _init():
	unit_type = "husares_infernales"
	min_damage_given = Global.settings.patricios.husares_infernales.attack.min_damage_given
	max_damage_given = Global.settings.patricios.husares_infernales.attack.max_damage_given
	max_speed = Global.settings.patricios.husares_infernales.max_speed
	life = Global.settings.patricios.husares_infernales.life
	bullet_speed = Global.settings.patricios.husares_infernales.attack.bullet.speed
	bullet_lifetime = Global.settings.patricios.husares_infernales.attack.bullet.duration
	coolDownAttackTime = Global.settings.patricios.husares_infernales.attack.cooldown
	rng = RandomNumberGenerator.new()
	init()
	
func set_sound_start(seektime):
	$WalkSound.seek(seektime)

func create_goal(endPosition):
	oGoal = Marker2D.new()
	oGoal.global_position = endPosition
	oGoalAssigned = oGoal

func assign_goal(oGoalParam):
	oGoalAssigned = oGoalParam
	
	
func _process(delta):
	#malon_sticked()
	attack()
	if speed == 0: queue_free()
		
	super(delta)

func attack():
	pass

func _on_combat_area_body_entered(body: Node2D) -> void:
	body.life = 0

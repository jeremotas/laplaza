extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
const GUNSHOT = preload("res://assets/original/sounds/gunshot6.mp3")
var oGoal
var entered = false
var iShoots = 0

func _init():
	unit_type = "carpincho"
	min_damage_given = 0
	max_damage_given = 0
	max_speed = 250
	life = 100000
	bullet_speed = 0
	bullet_lifetime = 0
	coolDownAttackTime = 1
	rng = RandomNumberGenerator.new()
	init()
	
func set_sound_start(seektime):
	$WalkSound.seek(seektime)
	pass
	
func play_sound_walk():
	$WalkSound.play()

func create_goal(endPosition):
	oGoal = Marker2D.new()
	oGoal.global_position = endPosition
	oGoalAssigned = oGoal

func assign_goal(oGoalParam):
	oGoalAssigned = oGoalParam
	
	
func _process(delta):
	status.moving = true
	#malon_sticked()
	#attack()
	if speed == 0: queue_free()
	super(delta)

func attack():
	
	pass	


func _on_timer_timeout():
	queue_free()

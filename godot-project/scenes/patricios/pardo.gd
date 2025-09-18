extends Character

@onready var animation = $AnimatedSprite2D
@export var life_given = 1
var tamboreo = false 
var tamboreaba = false
var added_tamboreo_speed = 0
#var bullet = preload("res://scenes/common/bullet.tscn")
const MATE = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "pardo"
	max_speed = Global.settings.patricios.pardo.max_speed
	life = Global.settings.patricios.pardo.life
	added_tamboreo_speed = Global.settings.patricios.pardo.speed_increase
	init()

func assign_goal(oGoal):
	oGoalAssigned = oGoal
	
func _process(delta):
	malon_sticked()
	if life == 0: tamboreo = false
	else: tamboreo = true
	tamborear()
	super(delta)
	
func tamborear():
	if tamboreo and not tamboreaba:
		tamboreaba = true
		Global.settings.boosters.tamboreo += added_tamboreo_speed
		print("TAMBOREANDO")
	elif not tamboreo and tamboreaba:
		tamboreaba = false
		Global.settings.boosters.tamboreo -= added_tamboreo_speed
		print("NO TAMBOREO POR AHORA")
		
	if Global.settings.boosters.tamboreo < 0:
		Global.settings.boosters.tamboreo = 0
		

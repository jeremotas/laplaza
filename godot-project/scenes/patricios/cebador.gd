extends Character

@onready var animation = $AnimatedSprite2D
@export var life_given = 1
var general_in_mate_area = false 
#var bullet = preload("res://scenes/common/bullet.tscn")

const aSoundMate = [
	preload("res://assets/created/sounds/mate/mate01.mp3"),
	preload("res://assets/created/sounds/mate/mate02.mp3"),
	preload("res://assets/created/sounds/mate/mate03.mp3"),
	preload("res://assets/created/sounds/mate/mate04.mp3"),
	preload("res://assets/created/sounds/mate/mate05.mp3"),
]

func _init():
	unit_type = "cebador"
	life_given = Global.settings.patricios.cebador.attack.life_given
	max_speed = Global.settings.patricios.cebador.max_speed
	life = Global.settings.patricios.cebador.life
	coolDownAttackTime = Global.settings.patricios.cebador.attack.cooldown

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
		if general_in_mate_area:
			#Hay que darle un mate al general.
			cebar_mate()
			
func cebar_mate():
	if oGoalAssigned.max_life > oGoalAssigned.life:
		oGoalAssigned.life += life_given
		if oGoalAssigned.life > oGoalAssigned.max_life:
			oGoalAssigned.life = oGoalAssigned.max_life
			
	var stream = random_pick_one(aSoundMate)
	AudioStreamManager.play({"stream": stream, "volume": AVS.get_db("mate_del_cebador"), "pitch": AVS.get_rpitch("mate_del_cebador")})


func _on_mate_area_body_entered(body: Node2D) -> void:
	if "unit_type" in body and body.unit_type == 'general':
		general_in_mate_area = true


func _on_mate_area_body_exited(body: Node2D) -> void:
	if "unit_type" in body and body.unit_type == 'general':
		general_in_mate_area = false

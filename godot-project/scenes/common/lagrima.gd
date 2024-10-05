extends CharacterBody2D

signal reward(faction)
var reward_emited = false
var experience_given = 0
var faction = 'ingleses'
var unit_type = 'lagrima'
var followUnit = null
var speed = 0.0
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().has_method("_on_reward"):
		reward.connect(get_parent()._on_reward)


func collected():
	if not reward_emited:		
		reward_emited = true
		reward.emit(faction, experience_given)
		visible = false
		queue_free()


func _physics_process(delta):	
	if not followUnit == null:
		move_to(delta)
	move_and_slide()

func move_to(delta):
#	print("move")
	speed += 100.0
	direction = (followUnit.global_position - global_position).normalized()
	velocity = direction * speed * delta
	#translate(direction * speed * delta)

func follow(oWho):
	#print('Debo seguir a', oWho)
	followUnit = oWho

func _on_area_2d_body_entered(body):
	if "unit_type" in body and body.unit_type == 'general':
		collected()

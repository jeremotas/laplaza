extends Sprite2D

signal reward(faction)
var reward_emited = false
var experience_given = 0
var faction = 'ingleses'

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().has_method("_on_reward"):
		reward.connect(get_parent()._on_reward)
	pass # Replace with function body.


func collected():
	if not reward_emited:		
		reward_emited = true
		reward.emit(faction, experience_given)
		visible = false
		#print("Suma XP = ", experience_given)
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	if "unit_type" in body and body.unit_type == 'general':
		collected()

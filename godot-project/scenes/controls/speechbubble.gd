extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func speech(sMessage):
	$MarginContainer/RichTextLabel.text = "[center]" + sMessage + "[/center]"
	visible = true
	$AnimationPlayer.play("title")
	await get_tree().create_timer(3).timeout
	
	visible = false
	
func advanced_speech(sMessage, time, color):
	$MarginContainer/RichTextLabel.text = "[center]" + sMessage + "[/center]"
	$MarginContainer/RichTextLabel.modulate = color
	visible = true
	$AnimationPlayer.play("title")
	await get_tree().create_timer(time).timeout
	
	visible = false

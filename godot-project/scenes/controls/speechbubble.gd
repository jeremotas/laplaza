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
	await get_tree().create_timer(4).timeout
	visible = false

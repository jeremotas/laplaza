extends CanvasLayer

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

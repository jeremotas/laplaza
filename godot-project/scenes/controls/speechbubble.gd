extends CanvasLayer

func _ready() -> void:
	TranslationServer.set_locale(Global.language)

func speech(sMessage):
	
	$MarginContainer/RichTextLabel.text = "[center]" + tr(sMessage) + "[/center]"
	visible = true
	$AnimationPlayer.play("title")
	await get_tree().create_timer(3).timeout
	
	visible = false
	
func advanced_speech(sMessage, time, color):
	$MarginContainer/RichTextLabel.text = "[center]" + tr(sMessage) + "[/center]"
	$MarginContainer/RichTextLabel.modulate = color
	visible = true
	$AnimationPlayer.play("title")
	await get_tree().create_timer(time).timeout
	
	visible = false

extends CanvasLayer
var titulo_piedra_elemetn

func _ready() -> void:
	TranslationServer.set_locale(Global.language)
	
	# speech("Hola tarolas") # Test

func speech(sMessage):
	
	$MarginContainer/TituloPiedra.set_title(tr(sMessage))
	visible = true
	$AnimationPlayer.play("title")
	await get_tree().create_timer(3).timeout
	
	visible = false
	
func advanced_speech(sMessage, time, color):
	$MarginContainer/TituloPiedra.set_title(tr(sMessage))
	$MarginContainer/TituloPiedra.modulate = color
	visible = true
	$AnimationPlayer.play("title")
	await get_tree().create_timer(time).timeout
	
	visible = false

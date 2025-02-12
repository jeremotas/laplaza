extends Node2D

var messageTimer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func message(sMessage, bPanic):
	$Mensaje.text = sMessage
	if bPanic:
		$AnimationPlayer.play("attack")
	else: 
		$AnimationPlayer.play("idle")
	
	$Surubi.show()	
	$Mensaje.show()
	
	messageTimer = Timer.new()
	add_child(messageTimer)
	messageTimer.autostart = true
	messageTimer.wait_time = 4
	messageTimer.one_shot = true
	messageTimer.timeout.connect(end_surubi_message)
	messageTimer.start()

func end_surubi_message():
	$Surubi.hide()
	$Mensaje.hide()

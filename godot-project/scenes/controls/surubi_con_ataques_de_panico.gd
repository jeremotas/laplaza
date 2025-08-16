extends Node2D

var messageTimer = null
var rng = RandomNumberGenerator.new()
var aMessagesToRead = []
var bTalking = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not bTalking and aMessagesToRead.size()>0:
		var sMessage = aMessagesToRead.pop_front()
		message_show(sMessage)

func message(sMessageType):
	var aPossibleMessages = Global.aSurubiTalks.get(sMessageType)
	# pick one
	var iSelectedMessageKey = rng.randi_range(0, aPossibleMessages.size() - 1)
	var sMessageSelected = aPossibleMessages[iSelectedMessageKey]
	var aMessages = sMessageSelected.split("__")
	for sMessage in aMessages:
		aMessagesToRead.push_back(sMessage)
	

func message_show(sMessage):
	var bPanic = false 
	sMessage = sMessage.strip_edges()
	if sMessage.contains("PANIC"):
		sMessage.replace("PANIC","")
		bPanic = true
	
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
	messageTimer.wait_time = 2
	messageTimer.one_shot = true
	messageTimer.timeout.connect(end_surubi_message)
	messageTimer.start()
	bTalking = true

func end_surubi_message():
	bTalking = false
	if aMessagesToRead.size() == 0:
		$Surubi.hide()
		$Mensaje.hide()
		

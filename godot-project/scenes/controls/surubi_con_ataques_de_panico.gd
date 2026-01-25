extends Node2D

var messageTimer = null
var rng = RandomNumberGenerator.new()
var aMessagesToRead = []
var bTalking = false
@onready var mensaje = $PanelMensaje/Mensaje
@onready var containermensaje = $PanelMensaje

var aSoundSurubiPanic = [
	preload("res://assets/original/sounds/surubi/surubi_corto_loco-001.mp3"),
	preload("res://assets/original/sounds/surubi/surubi_corto_loco-002.mp3"),
	preload("res://assets/original/sounds/surubi/surubi_corto_loco-003.mp3"),
]

var aSoundSurubi = [
	preload("res://assets/original/sounds/surubi/surubi_corto_tranqui-001.mp3"),
	preload("res://assets/original/sounds/surubi/surubi_corto_tranqui-002.mp3"),
	preload("res://assets/original/sounds/surubi/surubi_corto_tranqui-003.mp3"),
	preload("res://assets/original/sounds/surubi/surubi_corto_tranqui-004.mp3"),
	preload("res://assets/original/sounds/surubi/surubi_corto_tranqui-005.mp3"),
]

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
		sMessage = sMessage.replace("PANIC","")
		bPanic = true
	
	mensaje.text = sMessage
	if bPanic:
		$AnimationPlayer.play("attack")
	else: 
		$AnimationPlayer.play("idle")
	
	$Surubi.show()	
	containermensaje.show()
	
	messageTimer = Timer.new()
	add_child(messageTimer)
	messageTimer.autostart = true
	messageTimer.wait_time = 1
	messageTimer.one_shot = true
	messageTimer.timeout.connect(end_surubi_message)
	messageTimer.start()
	bTalking = true
	var stream = pick_sound_surubi_talking(bPanic)
	AudioStreamManager.play({"stream": stream, "volume": null, "pitch": null})

func pick_sound_surubi_talking(bPanic):
	var oStream = null
	if bPanic:
		var iSelectedSound = rng.randi_range(0, aSoundSurubiPanic.size() - 1)
		oStream = aSoundSurubiPanic[iSelectedSound]
	else:
		var iSelectedSound = rng.randi_range(0, aSoundSurubi.size() - 1)
		oStream = aSoundSurubi[iSelectedSound]
	return oStream

func end_surubi_message():
	bTalking = false
	if aMessagesToRead.size() == 0:
		$Surubi.hide()
		containermensaje.hide()

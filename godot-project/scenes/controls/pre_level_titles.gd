extends Node2D
#@onready var oSpeech = $SpeechBubble
@onready var oAnimationPlayer = $AnimationPlayer
@onready var oRichLabel = $RichTextLabel
@onready var oSpeechTimer = $SpeechTimer
var aMessagesInstance = []
var aMessages = [
	{"message": "Hace mucho mucho tiempo...", "time": 0.5, "next_trigger": 0.3},
	{"message": "En una galaxia muy muy lejana...", "time": 0.5, "next_trigger": 0.3},
#	{"message": "", "time": 0.1, "next_trigger": 0.5},
	{"message": "¡Ah no!", "time": 0.5, "next_trigger": 0.3},
	{"message": "¡Pará!", "time": 0.5, "next_trigger": 0.3},
	{"message": "Ese es otro imperio malvado...", "time": 1, "next_trigger": 0.3},
	{"message": "", "time": 0.2, "next_trigger": 0.3},
	{"message": "Buenos Aires\nAño 1807", "time": 1, "next_trigger": 0.3},
	{"message": "Los ingleses atacan por última vez.", "time": 1.5, "next_trigger": 0.3},
	{"message": "Liniers y los patricios\ndefienden la plaza.", "time": 1.5, "next_trigger": 0.3},
]
# Called when the node enters the scene tree for the first time.
func _ready():
	#print("READY")
	aMessagesInstance = aMessages
	#print(aMessagesInstance.size())
	Engine.time_scale = 1
	#oSpeechTimer.autostart = true
	#oSpeechTimer.wait_time = 0.5
	#oSpeechTimer.one_shot = true
	#oSpeechTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("ui_accept"):
		gotolevel()

func show_message(oMsg):
	#print(oMsg.message)
	oRichLabel.text = oMsg.message
	oRichLabel.visible = true
	oAnimationPlayer.play("title_in")
	await get_tree().create_timer(oMsg.time + 0.5).timeout
	oAnimationPlayer.play("title_out")
	await get_tree().create_timer(0.5).timeout
	oRichLabel.visible = false
	if (aMessagesInstance.size() > 0):
		oSpeechTimer.wait_time = oMsg.next_trigger
		oSpeechTimer.one_shot = true
		oSpeechTimer.start()
	else:
		gotolevel()
		
func gotolevel():
	SceneTransition.load_scene("res://scenes/levels/level.tscn")
	#get_tree().change_scene_to_file("res://scenes/levels/level.tscn")

func consume_message():
	var oMsg = aMessagesInstance.pop_front()
	show_message(oMsg)
	
	

func _on_speech_timer_timeout():
	#print("TIMER!")
	consume_message()
	pass # Replace with function body.

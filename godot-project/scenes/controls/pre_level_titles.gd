extends Node2D
#@onready var oSpeech = $SpeechBubble
@onready var oAnimationPlayer = $AnimationPlayer
@onready var oRichLabel = $RichTextLabel
@onready var oSpeechTimer = $SpeechTimer

const oTexts = preload("res://texts/pre_level_titles_txt.gd")

var aMessagesInstance = []



# Called when the node enters the scene tree for the first time.
func _ready():
	#print("READY")
	var rng = RandomNumberGenerator.new()
	var iSelectedMessage = 1
	var aMessages = oTexts.new().get_messages()
	if Global.save_data.lagrimas_acumuladas >= 1000:
		iSelectedMessage = rng.randi_range(0, aMessages.size() - 1)
	var sSelectedMessage = aMessages[iSelectedMessage]
	prepare_titles(sSelectedMessage)
	Engine.time_scale = 1

func prepare_titles(sMessage):
	var aLines = sMessage.split("\n", true)
	for iLine in aLines.size():
		var fTime = aLines[iLine].length() / 5.0 * 0.25
		var fNextTrigger = 0.3
		if aLines[iLine].strip_edges(true, true) == "":
			fTime = 0.25
			fNextTrigger = 0.1
		aMessagesInstance.push_back({"message": aLines[iLine], "time": fTime, "next_trigger": fNextTrigger})

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

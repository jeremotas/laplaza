extends CanvasLayer


@onready var time_control = $Control/MarginContainer/VBoxContainer/Panel/Time
@onready var level_control = $Control/MarginContainer/VBoxContainer/Panel/Nivel
@onready var level_progress_control = $Control/MarginContainer/VBoxContainer/Panel/LevelProgressBar
@onready var life_progress = $Control/MarginContainer/VBoxContainer/Panel/LifeProgressBar
@onready var plaza_progress = $Control/MarginContainer/VBoxContainer/Panel/PlazaProgressBar
#@onready var lagrimas_obtenidas = $Control/MarginContainer/VBoxContainer/Panel/Lagrimas

var tween:Tween
var tweenLife:Tween
var tweenPlaza:Tween
var iLevelProgressValueTo = null
var iLevelLifeValueTo = null
var iLevelPlazaValueTo = null

func ready():
	plaza_progress.modulate = 'ffffffCC'
	life_progress.modulate = '4d9c4eCC'
	

func change_time(iSecondsTotal):
	var iMinutes = iSecondsTotal / 60
	var iSeconds = iSecondsTotal % 60
	time_control.text = str(iMinutes).lpad(2, "0") + ":" + str(iSeconds).lpad(2, "0")
	
	
func change_level(iLevel):
	level_control.text = str(iLevel + 1)
	
func change_level_progress(iMinValue, iCount, iMaxValue):
	level_progress_control.min_value = iMinValue
	level_progress_control.max_value = iMaxValue
	
	if iLevelProgressValueTo != iCount:
		iLevelProgressValueTo = iCount
		#level_progress_control.value = iCount
		if tween:
			tween.kill()
		tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(level_progress_control, "value", iLevelProgressValueTo, 0.5)
		
	#lagrimas_obtenidas.text = str(iCount)
	#level_progress_control.text = str(iCount) + " / " + str(iTotal)
	
func change_life_indicator(value, max_value, invincible):
	
	if iLevelLifeValueTo != value:
		iLevelLifeValueTo = value
		#level_progress_control.value = iCount
		if tweenLife:
			tweenLife.kill()
		tweenLife = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tweenLife.tween_property(life_progress, "value", iLevelLifeValueTo, 0.5)
	else:
		life_progress.value = value	
	life_progress.max_value = max_value
	
	
	#life_progress.modulate = '4d9c4eCC'
	if invincible:
		life_progress.modulate = 'ffff00CC'
	if life_progress.value <= Global.settings.game.player_warning_life:
		life_progress.modulate = 'ff0000CC'
	
	#if invincible:
	#	life_progress.modulate = Color('#b7b700')
	#else:
	#	life_progress.modulate = Color('#00b760')
	
func change_plaza_indicator(value, max_value):
	
	if iLevelPlazaValueTo != max_value - value:
		iLevelPlazaValueTo = max_value - value
		#level_progress_control.value = iCount
		if tweenPlaza:
			tweenPlaza.kill()
		tweenPlaza = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tweenPlaza.tween_property(plaza_progress, "value", iLevelPlazaValueTo, 0.25)
	else: 
		plaza_progress.value = max_value - value
	plaza_progress.max_value = max_value
	#plaza_progress.modulate = 'ffffffCC'
	

func change(TheGameStats):
	change_level(TheGameStats.level)
	change_level_progress(TheGameStats.experience_prev_level, TheGameStats.experience, TheGameStats.experience_next_level)
	change_life_indicator(TheGameStats.life, TheGameStats.max_life, TheGameStats.invincible)
	change_plaza_indicator(TheGameStats.plaza, TheGameStats.max_plaza)
	
func surubi_message_call(sMessageType):
	if sMessageType == 'tutorial':
		set_highlight_surubi_visible(true)
	$Control/SurubiConAtaquesDePanico.message(sMessageType)

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.surubi_message.connect(surubi_message_call)
	pass
	
func set_highlight_surubi_visible(bVal):
	$Control/HighlightSurubi.visible = bVal
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

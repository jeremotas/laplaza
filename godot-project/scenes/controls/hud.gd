extends CanvasLayer


@onready var time_control = $Time
@onready var level_control = $MarginContainer/MarginContainer/HBoxContainer6/HBoxContainer6/VBoxContainer/Nivel
@onready var level_progress_control = $MarginContainer/MarginContainer/HBoxContainer6/HBoxContainer6/VBoxContainer/LevelProgressBar
@onready var life_progress = $MarginContainer/MarginContainer/HBoxContainer6/HBoxContainer4/VBoxContainer/LifeProgressBar
@onready var plaza_progress = $MarginContainer/MarginContainer/HBoxContainer6/HBoxContainer5/VBoxContainer/PlazaProgressBar
@onready var lagrimas_obtenidas = $MarginContainer/MarginContainer/HBoxContainer6/HBoxContainer7/VBoxContainer/HBoxContainer/Lagrimas



func change_time(iSecondsTotal):
	var iMinutes = iSecondsTotal / 60
	var iSeconds = iSecondsTotal % 60
	time_control.text = str(iMinutes).lpad(2, "0") + ":" + str(iSeconds).lpad(2, "0")
	
func change_level(iLevel):
	level_control.text = "Nivel " + str(iLevel + 1)
	
func change_level_progress(iMinValue, iCount, iMaxValue):
	level_progress_control.min_value = iMinValue
	level_progress_control.max_value = iMaxValue
	level_progress_control.value = iCount
	lagrimas_obtenidas.text = str(iCount)
	#level_progress_control.text = str(iCount) + " / " + str(iTotal)
	
func change_life_indicator(value, max_value, invincible):
	life_progress.value = value
	life_progress.max_value = max_value
	
	#if invincible:
	#	life_progress.modulate = Color('#b7b700')
	#else:
	#	life_progress.modulate = Color('#00b760')
	
func change_plaza_indicator(value, max_value):
	plaza_progress.value = max_value - value
	plaza_progress.max_value = max_value
	

func change(TheGameStats):
	change_level(TheGameStats.level)
	change_level_progress(TheGameStats.experience_prev_level, TheGameStats.experience, TheGameStats.experience_next_level)
	change_life_indicator(TheGameStats.life, TheGameStats.max_life, TheGameStats.invincible)
	change_plaza_indicator(TheGameStats.plaza, TheGameStats.max_plaza)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

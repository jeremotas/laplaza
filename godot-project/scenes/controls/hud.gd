extends CanvasLayer


@onready var time_control = $MarginContainer/HBoxContainer2/Time
@onready var level_control = $MarginContainer/HBoxContainer/IndicadorNivel
@onready var level_progress_control = $MarginContainer/HBoxContainer3/LevelProgress
@onready var life_progress = $MarginContainer/MarginContainer/HBoxContainer6/HBoxContainer4/LifeProgressBar
@onready var plaza_progress = $MarginContainer/MarginContainer/HBoxContainer6/HBoxContainer5/PlazaProgressBar


func change_time(iSecondsTotal):
	var iMinutes = iSecondsTotal / 60
	var iSeconds = iSecondsTotal % 60
	time_control.text = str(iMinutes).lpad(2, "0") + ":" + str(iSeconds).lpad(2, "0")
	
func change_level(iLevel):
	level_control.text = str(iLevel)
	
func change_level_progress(iCount, iTotal):
	level_progress_control.text = str(iCount) + " / " + str(iTotal)
	
func change_life_indicator(value, max_value, invincible):
	life_progress.value = value
	life_progress.max_value = max_value
	
	if invincible:
		life_progress.modulate = Color('#b7b700')
	else:
		life_progress.modulate = Color('#00b760')
	
func change_plaza_indicator(value, max_value):
	plaza_progress.value = value
	plaza_progress.max_value = max_value
	

func change(TheGameStats):
	change_level(TheGameStats.level)
	change_level_progress(TheGameStats.experience, TheGameStats.experience_next_level)
	change_life_indicator(TheGameStats.life, TheGameStats.max_life, TheGameStats.invincible)
	change_plaza_indicator(TheGameStats.plaza, TheGameStats.max_plaza)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

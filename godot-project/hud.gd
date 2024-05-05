extends CanvasLayer


func change_time(iSecondsTotal):
	var iMinutes = iSecondsTotal / 60
	var iSeconds = iSecondsTotal % 60
	$HBoxContainer2/Time.text = str(iMinutes).lpad(2, "0") + ":" + str(iSeconds).lpad(2, "0")
	
func change_level(iLevel):
	$HBoxContainer/IndicadorNivel.text = str(iLevel)
	
func change_level_progress(iCount, iTotal):
	$HBoxContainer3/LevelProgress.text = str(iCount) + " / " + str(iTotal)

func change(TheGameStats):
	change_level(TheGameStats.level)
	change_level_progress(TheGameStats.experience, TheGameStats.experience_next_level)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

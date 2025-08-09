extends Node2D

var ActualTimeScale = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$General.add_to_group('general_group')

func mini_shake():
	pass

func _on_reward(faction, xp):	
	#print('holis REWARD')
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func stop_music():
	pass
	
func start_music():
	pass

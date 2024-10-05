extends Node2D

var ActualTimeScale = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#await get_tree().create_timer(1).timeout
	#$General.init_barrilete_cosmico()
	$Arribeno.assign_goal($General)
	$Arribeno.add_to_faction('patricios')
	#$Arribeno.max_speed = 0
	
	$Moreno.assign_goal($General)
	$Moreno.add_to_faction('patricios')
	#$Moreno.max_speed = 0
	
	#$General.init_barrilete_cosmico()
	
	pass # Replace with function body.

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

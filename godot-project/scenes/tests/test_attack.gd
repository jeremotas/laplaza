extends Node2D

var ActualTimeScale = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$UnitSpawner.set_other_parameters({"guards":{"unit_type": "highlander", "quantity": 8}})
	$General.add_to_group('general_group')
	$Arribeno.assign_goal($General)
	$Arribeno.add_to_group('faccion_patricios')
	$EnemyGoal.faction = 'ingleses'
	await get_tree().create_timer(1.0).timeout
	$UnitSpawner.probabilitySpawnOnTimer = 100.0
	await get_tree().create_timer(2.0).timeout
	$EnemyGoal.defensa_de_obligado()
	

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

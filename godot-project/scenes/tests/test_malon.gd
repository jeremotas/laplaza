extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#$UnitSpawner.set_goal($General)
	#$UnitSpawner2.set_goal($General)
	$Cebador.assign_goal($General)
	pass

func _process(delta):
	print($General.life)
	pass

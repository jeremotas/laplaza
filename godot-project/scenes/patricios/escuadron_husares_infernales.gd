extends Node2D
var startPosition = Vector2.ZERO
var endPosition = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func startAttack(positionInit, positionEnd):
	global_position = positionInit
	create_order($HusarInfernal, positionEnd, 0)
	create_order($HusarInfernal2, positionEnd, 1)
	create_order($HusarInfernal3, positionEnd, 2)
	create_order($HusarInfernal4, positionEnd, 3)
	create_order($HusarInfernal5, positionEnd, 4)
	create_order($HusarInfernal6,positionEnd, 5)
	create_order($HusarInfernal7, positionEnd, 6)

func create_order(oHusar, endPosition, seektime):
	startPosition = oHusar.global_position
	#endPosition = startPosition
	#endPosition.x = startPosition.x + 1000
	oHusar.go_to(endPosition, true)
	oHusar.set_sound_start(seektime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  $HusarInfernal == null and $HusarInfernal2 == null and $HusarInfernal3 == null and $HusarInfernal4 == null and $HusarInfernal5 == null and $HusarInfernal6 == null and $HusarInfernal7 == null:
		queue_free()

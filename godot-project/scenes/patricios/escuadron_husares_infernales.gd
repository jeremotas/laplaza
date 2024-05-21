extends Node2D
var startPosition = Vector2.ZERO
var endPosition = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func startAttack(positionInit, positionEnd):
	global_position = positionInit
	create_order($HusarInfernal, positionEnd)
	create_order($HusarInfernal2, positionEnd)
	create_order($HusarInfernal3, positionEnd)
	create_order($HusarInfernal4, positionEnd)
	create_order($HusarInfernal5, positionEnd)
	create_order($HusarInfernal6,positionEnd)
	create_order($HusarInfernal7, positionEnd)

func create_order(oHusar, endPosition):
	startPosition = oHusar.global_position
	#endPosition = startPosition
	#endPosition.x = startPosition.x + 1000
	oHusar.go_to(endPosition, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  $HusarInfernal == null and $HusarInfernal2 == null and $HusarInfernal3 == null and $HusarInfernal4 == null and $HusarInfernal5 == null and $HusarInfernal6 == null and $HusarInfernal7 == null:
		queue_free()

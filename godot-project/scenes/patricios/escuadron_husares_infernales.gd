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
	create_order($HusarInfernal6, positionEnd, 5)
	create_order($HusarInfernal7, positionEnd, 6)

func create_order(oHusar, endPositionParam, seektime):
	startPosition = oHusar.global_position
	#endPosition = startPosition
	#endPosition.x = startPosition.x + 1000
	oHusar.go_to(endPositionParam, true)
	oHusar.set_sound_start(seektime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var iCant = 0
	if has_node('HusarInfernal'): iCant +=1 
	if has_node('HusarInfernal2'): iCant +=1 
	if has_node('HusarInfernal3'): iCant +=1 
	if has_node('HusarInfernal4'): iCant +=1 
	if has_node('HusarInfernal5'): iCant +=1 
	if has_node('HusarInfernal6'): iCant +=1 
	if has_node('HusarInfernal7'): iCant +=1 
	if iCant == 0:	
		queue_free()

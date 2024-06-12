extends Node2D
var startPosition = Vector2.ZERO
var endPosition = Vector2.ZERO
var bReady = false

# Called when the node enters the scene tree for the first time.
func _ready():
	bReady = false
	pass # Replace with function body.
	
func startAttack(positionInit, positionEnd):
	global_position = positionInit
	create_order($Carpincho, positionEnd, 0)
	create_order($Carpincho2, positionEnd, 1)
	create_order($Carpincho3, positionEnd, 2)
	create_order($Carpincho4, positionEnd, 3)
	create_order($Carpincho5, positionEnd, 4)
	create_order($Carpincho6,positionEnd, 5)
	create_order($Carpincho7, positionEnd, 6)
	create_order($Carpincho8, positionEnd, 7)
	create_order($Carpincho9, positionEnd, 8)
	create_order($Carpincho10, positionEnd, 9)
	create_order($Carpincho11, positionEnd, 10)
	create_order($Carpincho12, positionEnd, 11)
	create_order($Carpincho13, positionEnd, 12)
	create_order($Carpincho14, positionEnd, 13)
	create_order($Carpincho15, positionEnd, 14)
	create_order($Carpincho16, positionEnd, 15)
	create_order($Carpincho17, positionEnd, 16)
	create_order($Carpincho18, positionEnd, 17)
	create_order($Carpincho19, positionEnd, 18)
	create_order($Carpincho20, positionEnd, 19)
	create_order($Carpincho21, positionEnd, 20)
	create_order($Carpincho22, positionEnd, 21)
	create_order($Carpincho23, positionEnd, 22)
	create_order($Carpincho24, positionEnd, 23)
	create_order($Carpincho25, positionEnd, 24)
	create_order($Carpincho26, positionEnd, 25)
	create_order($Carpincho27, positionEnd, 26)
	create_order($Carpincho28, positionEnd, 27)
	bReady = true

func create_order(oCarpincho, endPositionParam, seektime):
	startPosition = oCarpincho.global_position
	#endPosition = startPosition
	#endPosition.x = startPosition.x + 1000
	oCarpincho.go_to(endPositionParam, true)
	oCarpincho.set_sound_start(seektime)
	
	oCarpincho.add_to_group("carpinchos")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if bReady and get_tree().get_nodes_in_group("carpinchos").size() == 0:
		queue_free()

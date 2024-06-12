extends Node2D
var EscuadronCarpinchos = preload("res://scenes/patricios/escuadron_carpinchos.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var E = EscuadronCarpinchos.instantiate()
	var positionAttack = Vector2.ZERO
	positionAttack.x = -200
	positionAttack.y = 240
	var endPosition = Vector2.ZERO
	endPosition.x = 2000
	endPosition.y = 240
	add_child(E)
	E.startAttack(positionAttack, endPosition)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

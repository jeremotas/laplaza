extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Nube1.position.x += 0.05
	$Nube2.position.x -= 0.005
	$Nube3.position.x += 0.05
	$Nube4.position.x += 0.005
	$Nube5.position.x -= 0.05
	
	if $Nube1.position.x > 780: $Nube1.position.x = -200
	if $Nube2.position.x < -180: $Nube2.position.x = 780
	if $Nube3.position.x > 780: $Nube3.position.x = -200
	if $Nube4.position.x > 780: $Nube4.position.x = -200
	if $Nube5.position.x < -180: $Nube5.position.x = 780
	
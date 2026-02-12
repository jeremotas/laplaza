extends CanvasLayer
var rng = RandomNumberGenerator.new()

var oR = preload("res://scenes/patricios/rocker.tscn")

func _init():
	pass

func start():
	$PatricioSolari.hide()
	$Cancion.stop()
	$Timer.start()
	fill_crowd()
	

func fill_crowd():
	for j in range(1,50):	
		for i in range(1,200):
			var iX = 5 * i
			var iY = -10 + 20 * j + rng.randi_range(-2,2)
			if not ((iX > 425 - 80 and iX < 425 + 80) and  (iY > 240 - 50 and iY < 240 + 50)):
				var oRN = oR.instantiate()
				oRN.global_position.x = iX
				oRN.global_position.y = iY
				$Crowd.add_child(oRN)
				
func kill_all():
	var aChildrens = $Crowd.get_children()
	for oChild in aChildrens:
		oChild.queue_free()


func _on_timer_timeout() -> void:
	await get_tree().create_timer(0.5).timeout
	#rayo()
	$PatricioSolari.show()
	$Cancion.play()
	await get_tree().create_timer(10.8).timeout
	#rayo()
	$PatricioSolari.hide()
	$Cancion.stop()
	kill_all()


func rayo():
	$Rayo.show()
	await get_tree().create_timer(0.1).timeout
	$SonidoTrueno.play()
	$Rayo.hide()
	await get_tree().create_timer(0.25).timeout
	$Rayo.show()
	await get_tree().create_timer(0.1).timeout
	$Rayo.hide()

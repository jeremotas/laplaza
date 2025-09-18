extends CanvasLayer

var rng = RandomNumberGenerator.new()

func start():
	change_rayo_timer()
	$TimerRayo.start()
	$SonidoLluvia.play()
	Global.emit_signal("surubi_message", "sudestada")
	
func stop():
	$TimerRayo.stop()
	$SonidoLluvia.stop()

func rayo():
	$Rayo.show()
	await get_tree().create_timer(0.1).timeout
	$SonidoTrueno.play()
	$Rayo.hide()
	await get_tree().create_timer(0.25).timeout
	$Rayo.show()
	await get_tree().create_timer(0.1).timeout
	$Rayo.hide()
	

func change_rayo_timer():
	var fNextRayo = rng.randf_range(3.2, 5.7)
	$TimerRayo.wait_time = fNextRayo
	get_parent().mini_shake()


func _on_timer_rayo_timeout() -> void:
	rayo()
	change_rayo_timer()

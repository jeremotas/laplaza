extends CanvasLayer

var rng = RandomNumberGenerator.new()

func start():
	$SonidoTedeum.play()
	$Tedeum.play()
	Global.emit_signal("surubi_message", "tedeum")
	
func stop():
	$SonidoTedeum.stop()
	$Tedeum.stop()

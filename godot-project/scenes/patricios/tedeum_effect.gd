extends CanvasLayer

var rng = RandomNumberGenerator.new()

func start():
	$SonidoTedeum.play()
	$Tedeum.play()
	pass
	
func stop():
	$SonidoTedeum.stop()
	$Tedeum.stop()
	pass

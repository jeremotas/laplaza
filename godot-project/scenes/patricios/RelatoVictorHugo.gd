extends AudioStreamPlayer2D

var pauseposition

func pause():
	#pauseposition = get_playback_position();
	#playing = false;
	stop()

func unpause():
	#seek(pauseposition)
	#playing = true;
	play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
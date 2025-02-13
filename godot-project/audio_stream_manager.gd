extends Node

var num_players = 24
var bus = "Efectos"

var available = []  # The available players.
var queue = []  # The queue of sounds to play.
var rng = RandomNumberGenerator.new()


func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	process_mode = Node.PROCESS_MODE_ALWAYS
	queue = []
	for i in num_players:
		var player = AudioStreamPlayer.new()
		add_child(player)
		available.append(player)
		player.finished.connect(_on_stream_finished.bind(player))
		player.bus = bus


func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play(sound_stream_object):
	if queue.size() < num_players:
		queue.append(sound_stream_object)


func _process(_delta):
	# Play a queued sound if any players are available.
	if not queue.size() == 0 and not available.size() == 0:
		var oStream = queue.pop_front()
		available[0].stream = oStream.stream
		if not oStream.volume == null and oStream.volume > 0.0:
			available[0].volume_db = oStream.volume
		else: 
			available[0].volume_db = 0.0
		if not oStream.pitch == null and  oStream.pitch > 0.0:
			available[0].pitch_scale = 1.0 + rng.randf_range(-oStream.pitch, oStream.pitch)
		else: 
			available[0].pitch_scale = 1.0
		available[0].play()
		available.pop_front()

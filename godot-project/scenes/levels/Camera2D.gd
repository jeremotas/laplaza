extends Camera2D

@export var randomStrength: float = 20.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var shakeTimer = null
var applied_shake = 0
var max_applied_shake = 0



func apply_shake_seconds(iTime, fStrength):
	if not shakeTimer:
		applied_shake = 0
		max_applied_shake = iTime * 2.0
		shakeTimer = Timer.new()
		randomStrength = fStrength
		add_child(shakeTimer)
		shakeTimer.autostart = true
		shakeTimer.wait_time = 0.1
		shakeTimer.one_shot = false
		shakeTimer.timeout.connect(apply_shake)
		shakeTimer.start()

func apply_shake():
	applied_shake += 0.1
	shake_strength = randomStrength
	if applied_shake >= max_applied_shake:
		if shakeTimer:
			shakeTimer.stop()
			shakeTimer.queue_free()
			shake_strength = 0.0
	
func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func make_zoom():
	zoom = zoom * 1.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0 , shakeFade * delta)
		#print(shakeFade)
		offset = random_offset()

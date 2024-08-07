extends Camera2D

@export var randomStrength: float = 20.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var shakeTimer = null
var applied_shake = 0
var max_applied_shake = 0

func apply_shake_seconds(iTime):
	applied_shake = 0
	max_applied_shake = iTime * 2
	shakeTimer = Timer.new()
	add_child(shakeTimer)
	shakeTimer.autostart = true
	shakeTimer.wait_time = 0.5
	shakeTimer.one_shot = false
	shakeTimer.timeout.connect(apply_shake)
	shakeTimer.start()

func apply_shake():
	applied_shake += 1
	shake_strength = randomStrength
	if applied_shake == max_applied_shake:
		shakeTimer.stop()
		shakeTimer.queue_free()
	
func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0 , shakeFade * delta)
		#print(shakeFade)
		offset = random_offset()

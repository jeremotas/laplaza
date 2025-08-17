extends CanvasLayer

var rng = RandomNumberGenerator.new()

@onready var tedeum_node = $Tedeum            # El objeto visual a animar
@onready var sfx = $SonidoTedeum              # Audio
@onready var anim = $AnimationPlayer                   # AnimationPlayer (si lo tenés)

func _ready():
	await get_tree().create_timer(1.0).timeout
	start()

func start():
	sfx.play()
	if anim and anim.has_method("play"):
		anim.play("default")
	Global.emit_signal("surubi_message", "tedeum")

	# Estado inicial: transparente y escala normal
	tedeum_node.modulate.a = 0.0
	tedeum_node.scale = Vector2.ONE

	# Tweens: bajar 300px en Y y subir alfa a 1 durante 2s
	var tw = create_tween()
	tw.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	var y0 = tedeum_node.position.y
	tw.tween_property(tedeum_node, "position:y", y0 + 250.0, 2.0)
	tw.parallel().tween_property(tedeum_node, "modulate:a", 1.0, 2.0)

	# Al terminar esos 2s: hacer zoom-out y desaparecer
	tw.tween_callback(_zoom_out_and_hide)

func _zoom_out_and_hide():
	var tw = create_tween()
	tw.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tw.tween_property(tedeum_node, "scale", Vector2.ZERO, 0.6)
	tw.parallel().tween_property(tedeum_node, "modulate:a", 0.0, 0.6)
	tw.tween_callback(_on_tedeum_done)

func _on_tedeum_done():
	tedeum_node.hide()
	sfx.stop()
	if anim and anim.has_method("stop"):
		anim.stop()

func stop():
	sfx.stop()
	if anim and anim.has_method("stop"):
		anim.stop()

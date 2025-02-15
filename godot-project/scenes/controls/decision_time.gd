extends CanvasLayer
var oCarta = preload("res://scenes/controls/carta.tscn")
var rng = RandomNumberGenerator.new()

@export var card_offset_x: float = 0.0
@export var rot_max_t: float = 5.0
@export var rot_max: float
@export var anim_offset_y: float = 0.1
@export var time_multiplier: float = 1.0
@export var fWaitHandTime : float = 0.25
@export var fScaleSelected : float = 1.25

@export var nivel = 1

var aCards : Array
var tween: Tween
var tween_animate: Tween

var sine_offset_mult: float = 0.2
var time: float = 0.0
var drawn: bool = false
var iActualPosition = 0
var ready_for_input: bool = false

const aPreDecisionSounds = {
	"primera": [
		preload("res://assets/created/sounds/primera.mp3"),
		preload("res://assets/created/sounds/primera_2.mp3"),
	],
	"segunda": [
		preload("res://assets/created/sounds/segunda.mp3"),
		preload("res://assets/created/sounds/segunda_2.mp3"),
	],
	"otra": [
		preload("res://assets/created/sounds/otra_1.mp3"),
		preload("res://assets/created/sounds/otra_2.mp3"),
		preload("res://assets/created/sounds/otra_3.mp3"),
		preload("res://assets/created/sounds/otra_4.mp3"),
		preload("res://assets/created/sounds/otra_5.mp3"),
		preload("res://assets/created/sounds/otra_6.mp3"),
		preload("res://assets/created/sounds/otra_7.mp3"),
		preload("res://assets/created/sounds/otra_8.mp3"),
	]
}

func init():
	#tween.custom_step(0.1)
	#tween_animate.custom_step(0.1)
	pass

func _ready():
	rot_max = deg_to_rad(rot_max_t)

func _process(delta):
	handle_input()
	# Animacion de cartas
	animate_cards_calculation(delta)
	
func handle_input():
	if visible == true and ready_for_input:
		var iOldPosition = iActualPosition
		if Input.is_action_just_pressed("ui_right") and aCards.size()-1 > iActualPosition:
			iActualPosition +=1
		if Input.is_action_just_pressed("ui_left") and 0 < iActualPosition:
			iActualPosition += -1
		if iOldPosition != iActualPosition:
			aCards[iActualPosition].grab_focus()
		
func animate_cards_calculation(delta):
	if drawn:
		time += delta
		for i in range(aCards.size()):
			var c: TextureButton = aCards[i]
			var val: float = sin(i + (time * time_multiplier))
			c.position.y += val * sine_offset_mult
		
func draw_hand() -> void:
	iActualPosition = 0
	var number = Global.save_data.mejoras.cartas_por_mano
	#await get_tree().create_timer(fWaitHandTime).timeout
	drawn = true
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	aCards.clear()
	
	var aMano = get_mano(number)
	
	for i in range(number):
		var oCardInstance: TextureButton = oCarta.instantiate()
		oCardInstance.set_move_on_selection(40)
		oCardInstance.prepare(aMano[i])
		add_child(oCardInstance)
		oCardInstance.global_position = $Control/PosicionMazo.global_position
		aCards.push_back(oCardInstance)
		var final_pos = $Control/PosicionMano.global_position
		var ancho_total = (oCardInstance.size.x - card_offset_x) * number
		final_pos.x += -ancho_total / 2 + (i * (oCardInstance.size.x + card_offset_x))
		var rot_radians: float = lerp_angle(-rot_max, rot_max, float(i)/float(number-1))
	
		# Animate pos
		tween.parallel().tween_property(oCardInstance, "position", final_pos, 0.5 + (i * 0.075))
		tween.parallel().tween_property(oCardInstance, "rotation", rot_radians, 0.5 + (i * 0.075))
	
	
		
	await tween.finished
	
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(set_process.bind(true))
	tween.tween_property(self, "sine_offset_mult", anim_offset_y, 1.5).from(0.0)
	animate_cards()
	#await tween.finished
	
	for i in range(number):
		aCards[i].card_flip(float(i) * 0.75)
		
	await get_tree().create_timer(1.75).timeout	
	ready_for_input = true
	aCards[0].grab_focus()
	
func undraw_cards(iSelectedCard) -> void:
	var child_count = aCards.size()
	var cSelected = aCards[iSelectedCard]
	var to_pos = $Control/PosicionMazo.global_position
	var to_pos_center = $Control/PosicionMano.global_position - Vector2((cSelected.size.x * fScaleSelected - card_offset_x) / 2, 0) 
	drawn = false
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "sine_offset_mult", 0.0, 0.9)
	
	for i in range(child_count-1, -1, -1):
		var c: TextureButton = aCards[i]
		if iSelectedCard != i:
			# Animate pos
			tween.parallel().tween_property(c, "global_position", to_pos, 0.3 + ((child_count - i) * 0.075))
			tween.parallel().tween_property(c, "rotation", 0.0, 0.3 + ((child_count - i) * 0.075))
		else:
			tween.parallel().tween_property(cSelected, "global_position", to_pos_center, 0.3)
			tween.parallel().tween_property(cSelected, "rotation", 0.0, 0.3)
			tween.parallel().tween_property(cSelected, "scale", Vector2(fScaleSelected, fScaleSelected), 0.3)
			$Control/Leyenda.text = ""
	
	await tween.finished
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(cSelected, "global_position", to_pos, 0.3)
	tween.parallel().tween_property(cSelected, "rotation", 0.0, 0.3)
	tween.parallel().tween_property(cSelected, "scale", Vector2(1, 1), 0.3)
	
	await tween.finished
	
	
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Control, "modulate:a", 0, 0.5)
	await tween.finished
	
	for i in range(child_count-1, -1, -1):
		var c: TextureButton = aCards[i]
		c.queue_free()
	
func get_mano(iCantidadCartas):
	var aMano = []
	for i in range(iCantidadCartas):
		var oCartaInfo = get_una_carta_mazo()
		oCartaInfo.posicion_en_mano = i
		aMano.push_back(oCartaInfo)
		
	return aMano

func get_una_carta_mazo():
	var oCartaMazo = Global.mazo.tomar_carta()
	return oCartaMazo
	
func animate_cards() -> void:
	if tween_animate and tween_animate.is_running():
		tween_animate.kill()
	tween_animate = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_animate.set_loops()
	for i in range(aCards.size()):
		var c: TextureButton = aCards[i]

func change_leyenda(sLeyenda):
	$Control/Leyenda.text = sLeyenda

func _on_visibility_changed():
	if visible:
		var stream = get_init_audio()
		AudioStreamManager.play({"stream": stream, "volume": null, "pitch": null})
		
		ready_for_input = false
		tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property($Control, "modulate:a", 1, 0.5)
		await tween.finished
		draw_hand()
		
func decision_elegida(sDecisionTomada, iSelectedCard):
	ready_for_input = false
	$ChangeLevel.play()
	await undraw_cards(iSelectedCard)
	get_parent().decision_time_end(sDecisionTomada)
	

func get_init_audio():
	print("NIVEL ", nivel)
	var aSonidos = aPreDecisionSounds.otra
	if nivel == 1:
		aSonidos = aPreDecisionSounds.primera
	if nivel == 2:
		aSonidos = aPreDecisionSounds.segunda
		
	var iSonidoRandom = rng.randi_range(0,aSonidos.size() - 1)
	var stream = aSonidos[iSonidoRandom]
	return stream 

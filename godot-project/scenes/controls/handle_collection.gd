extends Control
var oCarta = preload("res://scenes/controls/carta.tscn")
var rng = RandomNumberGenerator.new()

@export var card_offset_x: float = -95.0
@export var rot_max_t: float = 5.0
@export var rot_max: float
@export var anim_offset_y: float = 0.1
@export var time_multiplier: float = 1.0
@export var fWaitHandTime : float = 0.25
@export var fScaleSelected : float = 1.25

var sDecisionTomada
var iDecisionTomadaPosicion 

var aCards : Array
var tween: Tween
var tween_animate: Tween
var tween_mazo: Tween

var sine_offset_mult: float = 0.2
var time: float = 0.0
var drawn: bool = false
var iActualPosition = 0
var can_get_input = true
#var ready_for_input: bool = false

@onready var contenedor_cartas = $Control/ScrollContainer/GridContainer

func init():
	#tween.custom_step(0.1)
	#tween_animate.custom_step(0.1)
	pass

func _ready():
	rot_max = deg_to_rad(rot_max_t)
	get_tree().paused = true
	draw_hand()

func _process(delta):
	pass
	# Animacion de cartas
	#animate_cards_calculation(delta)
	
func _input(event):
	#if contenedor_cartas.ready_for_input:
		#if Input.is_action_just_pressed('ui_left'):
		#	handle_input('left', true)
		#elif Input.is_action_just_pressed('ui_right'):
		#	handle_input('right', true)
		#elif Input.is_action_pressed('ui_left'):
		#	handle_input('left', false)
		#elif Input.is_action_pressed('ui_right'):
		#	handle_input('right', false)
	
	if Input.is_action_just_pressed("pause"):
		volver_al_menu()



func volver_al_menu():
	Global.mazo.rearmar()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")

func handle_input(direction_pressed, set_can_get_input):
	if visible == true:
		can_get_input = set_can_get_input
		var iOldPosition = iActualPosition
		
		if direction_pressed == 'right' and aCards.size()-1 > iActualPosition:
			iActualPosition += 1
		if direction_pressed == 'left' and 0 < iActualPosition:
			iActualPosition += -1
			
		if iOldPosition != iActualPosition:
			aCards[iActualPosition].grab_focus()
		print("posicion actual" ,  iActualPosition, contenedor_cartas.get_children()[iActualPosition])
			

func correr_mazo(i):
	var aCartas = contenedor_cartas.get_children()
	for oCard in aCartas:
		oCard.global_position.x += 150 * i - card_offset_x
		
func draw_hand() -> void:
	iActualPosition = 0
	var number = Global.mazo.size()
	drawn = true
	aCards.clear()
	
	var aMano = get_mano(number)
	var last_card = null
	for i in range(number-1, -1, -1):
		if last_card == null or aMano[i].titulo != last_card.titulo:
			last_card = aMano[i]
			var oCardInstance: TextureButton = oCarta.instantiate()
			oCardInstance.prepare(aMano[i])
			oCardInstance.set_move_on_selection(0.0)
			oCardInstance.card_move_on_focus = false
			contenedor_cartas.add_child(oCardInstance)
			contenedor_cartas.move_child(oCardInstance, 0)
			oCardInstance.card_flip(i*0.05 + 0.1)
			#aCards.push_front(oCardInstance)
			#oCardInstance.global_position = $Control/PosicionMazo.global_position
			#oCardInstance.set_move_on_selection(120)
		#aCards = contenedor_cartas.get_children()
	contenedor_cartas.get_children()[0].grab_focus()
	contenedor_cartas.ready_for_input = true
	#$Control/Label.text = str(contenedor_cartas.get_children().size()) + " cartas"
	visible = true
	
	
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
	
func decision_elegida(sDecisionTomadaCarta, iPosicion):
	if aCards.size() < 20:
		$AcceptDialog.popup_centered()
		$AcceptDialog.show()
		$AcceptDialog.grab_focus() 
	else:
		sDecisionTomada = sDecisionTomadaCarta
		iDecisionTomadaPosicion = iPosicion
		$ConfirmationDialog.popup_centered()
		$ConfirmationDialog.show()
		$ConfirmationDialog.grab_focus() 
	
func _on_timer_timeout():
	can_get_input = true

func _on_confirmation_dialog_canceled():
	pass # Replace with function body.

func _on_confirmation_dialog_confirmed():
	pass

extends Control
var oCarta = preload("res://scenes/controls/carta.tscn")
var rng = RandomNumberGenerator.new()

@export var card_offset_x: float = -95.0
@export var anim_offset_y: float = 0.1
@export var time_multiplier: float = 1.0
@export var fWaitHandTime : float = 0.25
@export var fScaleSelected : float = 1.0

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
	pass

func _ready():
	get_tree().paused = true
	preparar_coleccion()
	
func _input(event):
	if Input.is_action_just_pressed("pause"):
		volver_al_menu()

func volver_al_menu():
	Global.mazo.rearmar()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")
			
		
func preparar_coleccion() -> void:
	var aTiposDeCartas = Global.mazo.get_diccionario_de_cartas()
	var i = 0;
	for sDecision in aTiposDeCartas:
		var oCardGen = Global.mazo.crear_carta(sDecision)
		var oCardInstance: TextureButton = oCarta.instantiate()
		oCardInstance.prepare(oCardGen)
		oCardInstance.set_move_on_selection(0.0)
		oCardInstance.card_move_on_focus = false
		oCardInstance.set_chip_counter(aTiposDeCartas[sDecision])
		contenedor_cartas.add_child(oCardInstance)
		#contenedor_cartas.move_child(oCardInstance, 0)
		oCardInstance.card_flip(i*0.05 + 0.1)
		i += 1
	
	contenedor_cartas.get_children()[0].grab_focus()
	contenedor_cartas.ready_for_input = true
	visible = true

func get_una_carta_de(sDecisionTomada):
	pass	
	
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
		agregar_a_mazo(sDecisionTomada)
	
func _on_timer_timeout():
	can_get_input = true
	
func agregar_a_mazo(sDecisionTomada):
	recalcular_mazo()
	recalcular_cartas_en_coleccion()

func quitar_del_mazo(sDecisionTomada):
	recalcular_mazo()
	recalcular_cartas_en_coleccion()

func recalcular_mazo():
	pass 

func recalcular_cartas_en_coleccion():
	pass

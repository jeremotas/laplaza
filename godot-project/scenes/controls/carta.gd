extends TextureButton

var sTipo = ""
var sDecisionTimeMessage = ""
var iCantidad = 0
var sImagenPrincipal = ""
var iPosicionEnMano = 0
var sTitulo = ""
var sLeyenda = ""
var iMoveOnSelection = 15
@onready var oTitulo = $Titulo
var original_position = null

const rsNormalTextureUnidad = preload("res://assets/created/carta_unidad_frente.png")
const rsNormalTextureEvento = preload("res://assets/created/carta_evento_frente.png")
const rsNormalTextureTruco = preload("res://assets/created/carta_truco_frente.png")

#const rsSelectedTextureEvento = preload("res://assets/created/carta_evento_frente_focus.png")
#const rsSelectedTextureUnidad = preload("res://assets/created/carta_unidad_frente_focus.png")
#const rsSelectedTextureTruco = preload("res://assets/created/carta_truco_frente_focus.png")

const rsSelectedTextureEvento = preload("res://assets/created/carta_evento_frente.png")
const rsSelectedTextureUnidad = preload("res://assets/created/carta_unidad_frente.png")
const rsSelectedTextureTruco = preload("res://assets/created/carta_truco_frente.png")

var tween: Tween
#res://assets/created/carta_frente.png

func init():
	#tween.custom_step(0.1)
	pass

func _ready():
	global_position.x = 640 - 84
	global_position.y = 480
	$Titulo.text = sTitulo

func _process(_delta):
	#print(global_position)
	pass

func prepare(oCartaValues):
	sTipo = oCartaValues.tipo
	sDecisionTimeMessage = oCartaValues.decision_time_message
	iCantidad = oCartaValues.cantidad
	sTitulo = oCartaValues.titulo
	iPosicionEnMano = oCartaValues.posicion_en_mano
	sLeyenda = oCartaValues.leyenda
	# Preparo texturas del boton
	prepare_textures()
	# Preparo los textos

func prepare_textures():
	if sTipo == "unidad":
		texture_normal = rsNormalTextureUnidad
		texture_hover = rsSelectedTextureUnidad
		texture_focused = rsSelectedTextureUnidad
	elif sTipo == "evento":
		texture_normal = rsNormalTextureEvento
		texture_hover = rsSelectedTextureEvento
		texture_focused = rsSelectedTextureEvento	
	elif sTipo == "truco":
		texture_normal = rsNormalTextureTruco
		texture_hover = rsSelectedTextureTruco
		texture_focused = rsSelectedTextureTruco
	pass

func _on_pressed():
	print("Mensaje", iPosicionEnMano, sDecisionTimeMessage)
	get_parent().decision_elegida(sDecisionTimeMessage, iPosicionEnMano)


func _on_focus_entered():
	card_up()
	var sLeyendaT = sLeyenda.replace(" __ ", "\n")
	get_parent().change_leyenda(sLeyendaT)
	

func _on_focus_exited():
	card_down()

func _on_mouse_entered():
	card_up()

func _on_mouse_exited():
	card_down()

func card_up():
	if original_position == null:
		original_position = global_position
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	var final_pos = original_position
	final_pos.y += -iMoveOnSelection
	tween.parallel().tween_property(self, "position", final_pos, 0.1)
	#global_position.y = original_position.y - iMoveOnSelection
	
	
func card_down():
	if original_position == null:
		original_position = global_position
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	var final_pos = original_position
	final_pos.y += iMoveOnSelection
	tween.parallel().tween_property(self, "position", final_pos, 0.1)
	#global_position.y = original_position.y
	

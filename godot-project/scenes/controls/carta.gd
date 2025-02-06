extends TextureButton

var sTipo = ""
var sDecisionTimeMessage = ""
var iCantidad = 0

var sImagenPrincipal = ""
var sTitulo = ""


var oTiposDeCartas = {
	#{"normal": "", "selected": ""}
	"normal": {
		"textures": {"normal": "carta_frente", "selected": "carta_frente_focus"}
	},
	"especial": {
		"textures": {"normal": "carta_frente_roja", "selected": "carta_frente_roja_focus"}
	}
}
#res://assets/created/carta_frente.png

func prepare(oCartaValues):
	sTipo = oCartaValues.tipo
	sDecisionTimeMessage = oCartaValues.decision_message
	iCantidad = oCartaValues.cantidad
	
	# Preparo texturas del boton
	# Preparo los textos


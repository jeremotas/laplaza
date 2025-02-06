extends TextureButton

var sTipo = ""
var sDecisionTimeMessage = ""
var iCantidad = 0
var sImagenPrincipal = ""
@onready var oTitulo = $Titulo

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

func _ready():
	global_position.x = 640 - 84
	global_position.y = 480

func _process(_delta):
	#print(global_position)
	pass

func prepare(oCartaValues):
	sTipo = oCartaValues.tipo
	sDecisionTimeMessage = oCartaValues.decision_message
	iCantidad = oCartaValues.cantidad
	oTitulo.text = oCartaValues.titulo
	
	# Preparo texturas del boton
	# Preparo los textos


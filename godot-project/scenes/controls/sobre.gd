extends TextureButton

const textura_azul = preload("res://assets/created/cartas/sobre_azul.png")
const textura_verde = preload("res://assets/created/cartas/sobre_verde.png")
const textura_rojo = preload("res://assets/created/cartas/sobre_rojo.png")

func start_particles():
	$Implosion.emitting = true

func type(sType):
	if sType == "azul":
		texture_normal = textura_azul
	if sType == "rojo":
		texture_normal = textura_rojo
	if sType == "verde":
		texture_normal = textura_verde


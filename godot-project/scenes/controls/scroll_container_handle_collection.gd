extends ScrollContainer

# Ajusta este valor para el aire que quieres arriba/abajo
@export var extra_margin: int = 32 

func _ready():
	# Importante: Follow Focus debe estar en OFF en el Inspector
	await get_tree().process_frame
	
	# Buscamos los TextureButtons o cualquier BaseButton
	for boton in $GridContainer.get_children():
		if boton is BaseButton:
			boton.focus_entered.connect(_on_focus_entered.bind(boton))

func _on_focus_entered(boton: Control):
	ensure_control_visible(boton)
	await get_tree().process_frame
	
	var v_scroll = get_v_scroll_bar()
	var boton_pos = boton.position.y
	var boton_height = boton.size.y
	var objetivo_y = scroll_vertical # Valor por defecto (sin cambio)
	
	# Calculamos el destino con el margen
	if scroll_vertical > boton_pos - extra_margin:
		objetivo_y = max(0, boton_pos - extra_margin)
	
	var view_bottom = scroll_vertical + size.y
	if view_bottom < boton_pos + boton_height + extra_margin:
		objetivo_y = min(v_scroll.max_value, boton_pos + boton_height + extra_margin - size.y)

	# ESTA ES LA LÍNEA QUE CAMBIA: En lugar de asignar, animamos
	var tween = create_tween()
	tween.tween_property(self, "scroll_vertical", objetivo_y, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

extends Node

# Los valores posibles de los dbs pueden ser positivos o negativos (siempre decimales, agregar .0).
# Si es null el valor, toma los db por defecto.
const dbs = {
	# Interfaz
		# Sonidos del menu.
		"menu_movimiento": -4.0,
		"menu_salir": null,
		"menu_retroceder": null,
		"adentro_inicio_juego": null,
		"pre_level_titles_background_sound": null, # Sonido de fondo de cuando arranca un nivel.
	
		# Otros
		"inicio_jugar_mano": null,
		"decision_de_carta_tomada": null, # adentro...
		"card_up": null, # Carta dada vuelta (creo)
		"card_flip": null,
		
		
	# Sonidos de ataque
	"attack_royal_marine": null, 
	"attack_ingles_normal": null,
	"attack_highlander": null,
	"attack_green_soldier": null,
	"attack_cannon": null,
	
	"attack_patricio": null,
	"attack_mignon": null,
	"attack_general": null, # Ataque de liniers
	"attack_arribeno": null, 
	"attack_correntino": null, 
	
	"mate_del_cebador": 4.0, # Elije uno entre 4 chupadas de mate
	
	"explotion": null, # moreno y zapador
	"explotion_water": null, # ollas del pueblo
	
	# Sonidos en nivel
	"muerte_del_general": null,
	"nueva_oleada": null,
	"aviso_ingles_en_zona": null, # no acepta pitch, si hace falta lo armamos.
	"entra_ingles_al_mastil": null, # no acepta pitch, si hace falta lo armamos.
	
	# Otros sonidos
	"surubi": -12.0,
	"carpinchos_walk": null,
	"lagrima_tomada": 10.0,
	
	# Cartas eventuales
	"carta_mate": null, # Elije uno entre 4 chupadas de mate mismo que el cebador.
	"tedeum_stinger": null,
	"manuela_stinger": null,
	"manuela_stinger_out": null,
	"cadenas_stinger": -6.0,
	"cadenas_stinger_out": null,
	"husares_infernales_walk": null,
	"sudestada_lluvia": null,
	"sudestada_trueno": null,
	"relato_victor_hugo": 6.0,
	
}

# Si se agrega un pitcheo, este hace random entre el valor -PITCH y PITCH al reproducir el sonido.
# Cuando quieras agrega uno para poder pitchearlo.
const random_pitches = {
	"menu_movimiento": null,
	"lagrima_tomada": 0.2,
	"attack_ingles_normal": 0.2,
}

func get_db(sName):
	var fValue = null
	if sName in dbs:
		fValue = dbs[sName] 
		
	return fValue

func get_rpitch(sName):
	var fValue = null
	if sName in random_pitches:
		fValue = dbs[sName] 
		
	return fValue

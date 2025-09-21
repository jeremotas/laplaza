extends Node

signal surubi_message(label)

var save_data:SaveData
var mazo:Mazo

var settings = {
	"demo": true,
	"game": {
		"init_level": "level",
		"player_goal": 600,
		"enemy_goal": 30,
		"player_max_life": 15,
		"player_warning_life": 3,
		"min_player_life_after_level_up": 0,
		"initial_conditions": {
			"units_arrived": 0,
			"life": 15,
			"malon": {
				"granadero": 0,
				"correntino": 0,
				"moreno": 0,
				"husares_infernales": 0,
				"arribeno": 0,
				"cebador": 0,
				"mignon": 0,
				"pardo": 0,
			},
			"level": 0,
			"time": 0,
		},
		"initial_cards": {
			"granadero": 5,
			"moreno": 1,
			"arribeno": 1,
			"correntino": 1,
			"husares_infernales": 1,
			"matecito": 3,
			"barrilete_cosmico": 0,
			"ollas_del_pueblo": 0,
			"cebador": 0
		},
		"mejoras": {
			"granadero": {
				"valor": 4000,
				"maxima_cantidad": 3
			},
			"correntino": {
				"valor": 5000,
				"maxima_cantidad": 3
			},
			"moreno": {
				"valor": 10000,
				"maxima_cantidad": 3
			},
			"arribeno": {
				"valor": 2000,
				"maxima_cantidad": 3
			}
		}
	},
	"boosters": {
		"ingleses": 0.0,
		"patricios": 0.0	,
		"tamboreo": 0.0
	},
	"patricios": {
		"general": {
			"life": 15,
			"max_speed": 150,
			"attack":{
				"bullet": {
					"speed": 400,
					"duration": 1,
				},
				"cooldown": 1,
				"min_damage_given": 2,
				"max_damage_given": 2
			},
			"agua_hirviendo": {
				"min_damage_given": 2,
				"max_damage_given": 2,
				"cooldown": 5,
				"time_reduce_step": 2,
				"bullet": {
					"speed":400,
					"duration": 0.75,
					"explotion": {
						"duration": 0.65,
						"scale": 30,
						"particle": "explosion_agua"
					}
				}
			},
			"barrilete_cosmico": {
				"life": 20000000,
				"min_damage_given": 100000,
				"max_damage_given": 100000,
				"max_speed": 500,
				"bullet": {
					"speed":800,
					"duration": 0.01,
					"explotion": {
						"duration": 0.01,
						"scale": 30,
						"particle": "explosion"
					}
				},
				"cooldown": 0.01,
				"duration": 3.5
			}
		},
		"granadero": {
			"life": 5,
			"max_speed": 140,
			"attack":{
				"bullet": {
					"speed": 400,
					"duration": 1.0,
				},
				"cooldown": 1,
				"min_damage_given": 2,
				"max_damage_given": 2
			},
		},
		"moreno": {
			"life": 8,
			"max_speed": 140,
			"attack":{
				"bullet": {
					"speed": 200,
					"duration": 0.75,
					"explotion": {
						"duration": 1,
						"scale": 30,
						"particle": "explosion"
					}
				},
				"cooldown": 4,
				"min_damage_given": 2,
				"max_damage_given": 2
			},
		},
		"cebador": {
			"life": 1,
			"max_speed": 120,
			"attack":{
				"cooldown": 30,
				"life_given": 2,
				"min_damage_given": 0,
				"max_damage_given": 0
			},
		},
		"pardo": {
			"life": 2,
			"max_speed": 140,
			"speed_increase": 60,
		},
		"arribeno": {
			"life": 8,
			"max_speed": 140,
			"attack":{
				"bullet": {
					"speed": 200,
					"duration": 1.0,
				},
				"cooldown": 3,
				"min_damage_given": 2,
				"max_damage_given": 2
			},
		},
		"correntino": {
			"life": 5,
			"max_speed": 140,
			"attack":{
				"bullet": {
					"speed": 600,
					"duration": 2.0,
				},
				"cooldown": 3,
				"min_damage_given": 4,
				"max_damage_given": 4
			},
		},
		"manuela_pedraza": {
			"life": 999999,
			"max_speed": 150,
			"death_time": 15.0, 
			"attack":{
				"cooldown": 0.15,
				"min_damage_given": 100,
				"max_damage_given": 100
			},
		},
		"husares_infernales": {
			"life": 100,
			"max_speed": 300,
			"attack":{
				"bullet": {
					"speed": 500,
					"duration": 2.0,
				},
				"cooldown": 0.5,
				"min_damage_given": 50,
				"max_damage_given": 50
			}
		},
		"mignon": {
			"life": 2,
			"max_speed": 140,
			"attack":{
				"bullet": {
					"speed": 400,
					"duration": 1.5,
				},
				"cooldown": 2.0,
				"min_damage_given": 1,
				"max_damage_given": 1
			},
		},
		"sudestada": {
			"duration": 15.0,
			"speed_booster": -0.7
		},
		"tedeum": {
			"duration": 15.0
		},
		"defensa_de_obligado": {
			"life": 30
		}
	},
	"ingleses": {
		"soldado": {
			"life": 2,
			"max_speed": 50,
			"experience_given": 2,
			"attack":{
				"bullet": {
					"speed": 200,
					"duration": 1.0,
				},
				"probability": 20,
				"cooldown": 2,
				"min_damage_given": 1,
				"max_damage_given": 1
			}
		},
		"royal_marine": {
			"life": 4,
			"max_speed": 60,
			"experience_given": 6,
			"attack":{
				"bullet": {
					"speed": 300,
					"duration": 1.0,
				},
				"cooldown": 2.0,
				"probability": 80,
				"min_damage_given": 3,
				"max_damage_given": 3
			}
		},
		"highlander": {
			"life": 5,
			"max_speed": 30,
			"experience_given": 4,
			"scale_probability": 100,
			"attack":{
				"bullet": {
					"speed": 150,
					"duration": 2.0,
				},
				"cooldown": 4,
				"probability": 10,
				"min_damage_given": 1,
				"max_damage_given": 1
			}
		},
		"green_soldier": {
			"life": 2,
			"max_speed": 90,
			"experience_given": 4,
			"attack":{
				"bullet": {
					"speed": 300,
					"duration": 0.5,
				},
				"cooldown": 4,
				"probability": 20,
				"min_damage_given": 1,
				"max_damage_given": 1
			}
		},
		"english_cavalry": {
			"life": 3,
			"max_speed": 120,
			"experience_given": 8,
			"attack":{
				"trample": {
					"speed": 180,
					"duration": 3.0,
				},
				"cooldown": 5.0,
				"min_damage_given": 2,
				"max_damage_given": 2
			}
		},
		"cannon": {
			"life": 30,
			"max_speed": 20,
			"experience_given": 24,
			"scale_probability": 0,
			"attack":{
				"bullet": {
					"speed": 150,
					"duration": 2.0,
					"explotion": {
						"duration": 1.0,
						"scale": 30,
						"particle": "explosion"
					}
				},
				"cooldown": 10,
				"probability": 10,
				"min_damage_given": 14,
				"max_damage_given": 14
			}
		},
		"zapador": {
			"life": 5,
			"max_speed": 45,
			"experience_given": 4,
			"attack":{
				"bullet": {
					"speed": 10,
					"duration": 0.5,
					"explotion": {
						"duration": 1.0,
						"scale": 60,
						"particle": "explosion_big"
					}
				},
				"min_damage_given": 10,
				"max_damage_given": 10
			}
		},
	},
	"sobres": {
		"azul": [
			{"name": "granadero", "quantity": 80},
			{"name": "arribeno", "quantity": 80},
			{"name": "moreno", "quantity": 10},
			{"name": "correntino", "quantity": 20},
			{"name": "cebador", "quantity": 2},
			{"name": "ollas_del_pueblo", "quantity": 10},
			{"name": "ataque_husares_infernales", "quantity": 2},
			{"name": "barrilete_cosmico", "quantity": 2},
		],
		"verde": [
			{"name": "granadero", "quantity": 50},
			{"name": "arribeno", "quantity": 50},
			{"name": "moreno", "quantity": 4},
			{"name": "cebador", "quantity": 4},
			{"name": "ollas_del_pueblo", "quantity": 30},
			{"name": "correntino", "quantity": 30},
			{"name": "ataque_husares_infernales", "quantity": 4},
			{"name": "barrilete_cosmico", "quantity": 4}
		],
		"rojo": [
			{"name": "granadero", "quantity": 0},
			{"name": "arribeno", "quantity": 0},
			{"name": "moreno", "quantity": 20},
			{"name": "correntino", "quantity": 20},
			{"name": "cebador", "quantity": 20},
			{"name": "ollas_del_pueblo", "quantity": 20},
			{"name": "ataque_husares_infernales", "quantity": 20},
			{"name": "barrilete_cosmico", "quantity": 20},
			{"name": "manuela_pedraza", "quantity": 20}
		]
	}
}

var aSurubiTalks = {
	"mensaje_inicial": [
		"Ahí vienen!! __ Corran por sus vidas!!! PANIC",
		"Estos vienen por el té? __ TE voy a dar!!! PANIC",
		"Invasión? __ Inversión? __ FMI... TODO LO MISMO PANIC __ Seguimos resistiendo.",
		"Elección o relección? __ para mí es la misma... __ #@#@$#@#@ PANIC"
	],
	"tedeum": [
		"Ya lo dijo Francis... __ HAGAN LÍO! PANIC",
		"Ay, diosito santo... __ bajamela del cielo.",
		"Arranca el genio... __ Ah, no... ese era otro. __ Ehm... Sí, DIOS, AYUDAAAA!"
	],
	"sudestada": [
		"Miau, miau, miau... __ Miau, miaaaaaauuu __ Llueve sobre mojado! PANIC",
		"MABEEEEELLL PANIC __ Hay que entrar la ropa!!",
		"Que llueva... Que llueva... __ La vieja está en la cueva..."
	]
}

func _ready():
	save_data = SaveData.load_or_create()
	mazo = Mazo.crear(save_data.original_cards)

extends Node

var save_data:SaveData
var mazo:Mazo

var settings = {
	"game": {
		"init_level": "level",
		"player_goal": 600,
		"enemy_goal": 12,
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
			},
			"level": 0,
			"time": 0,
		},
		"initial_cards": {
			"granadero": 5,
			"moreno": 0,
			"arribeno": 2,
			"correntino": 0,
			"husares_infernales": 0,
			"matecito": 5,
			"barrilete_cosmico": 0,
			"ollas_del_pueblo": 0,
			"cebador": 1
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
		"patricios": 0.0	
	},
	"patricios": {
		"general": {
			"life": 20,
			"max_speed": 250,
			"attack":{
				"bullet": {
					"speed": 250,
					"duration": 1.2,
				},
				"cooldown": 1,
				"min_damage_given": 1,
				"max_damage_given": 1
			},
			"agua_hirviendo": {
				"min_damage_given": 2,
				"max_damage_given": 2,
				"cooldown": 10,
				"time_reduce_step": 2,
				"bullet": {
					"speed":200,
					"duration": 2,
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
				"duration": 8
			}
		},
		"granadero": {
			"life": 7,
			"max_speed": 100,
			"attack":{
				"bullet": {
					"speed": 150,
					"duration": 2.0,
				},
				"cooldown": 1,
				"min_damage_given": 1,
				"max_damage_given": 1
			},
		},
		"moreno": {
			"life": 14,
			"max_speed": 150,
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
				"min_damage_given": 1,
				"max_damage_given": 1
			},
		},
		"cebador": {
			"life": 6,
			"max_speed": 80,
			"attack":{
				"cooldown": 4,
				"life_given": 1,
				"min_damage_given": 0,
				"max_damage_given": 0
			},
		},
		"arribeno": {
			"life": 14,
			"max_speed": 150,
			"attack":{
				"bullet": {
					"speed": 200,
					"duration": 0.3,
					"explotion": {
						"duration": 0.75,
						"scale": 15,
						"particle": "escopetazo"
					}
				},
				"cooldown": 2,
				"min_damage_given": 1,
				"max_damage_given": 1
			},
		},
		"correntino": {
			"life": 3,
			"max_speed": 50,
			"attack":{
				"bullet": {
					"speed": 500,
					"duration": 2.0,
				},
				"cooldown": 5,
				"min_damage_given": 4,
				"max_damage_given": 4
			},
		},
		"manuela_pedraza": {
			"life": 999999,
			"max_speed": 120,
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
		"sudestada": {
			"duration": 15.0,
			"speed_booster": -0.7
		},
		"tedeum": {
			"duration": 22.0
		},
		"defensa_de_obligado": {
			"life": 30
		}
	},
	"ingleses": {
		"soldado": {
			"life": 1,
			"max_speed": 20,
			"experience_given": 1,
			"attack":{
				"bullet": {
					"speed": 150,
					"duration": 2.0,
				},
				"probability": 20,
				"cooldown": 2,
				"min_damage_given": 1,
				"max_damage_given": 1
			}
		},
		"royal_marine": {
			"life": 4,
			"max_speed": 30,
			"experience_given": 6,
			"attack":{
				"bullet": {
					"speed": 280,
					"duration": 1.5,
				},
				"cooldown": 1.5,
				"probability": 80,
				"min_damage_given": 3,
				"max_damage_given": 4
			}
		},
		"highlander": {
			"life": 5,
			"max_speed": 12,
			"experience_given": 4,
			"scale_probability": 30,
			"attack":{
				"bullet": {
					"speed": 150,
					"duration": 2.0,
				},
				"cooldown": 4,
				"probability": 10,
				"min_damage_given": 4,
				"max_damage_given": 4
			}
		},
		"green_soldier": {
			"life": 2,
			"max_speed": 40,
			"experience_given": 4,
			"attack":{
				"bullet": {
					"speed": 150,
					"duration": 0.5,
				},
				"cooldown": 4,
				"probability": 20,
				"min_damage_given": 1,
				"max_damage_given": 1
			}
		},
		"english_cavalry": {
			"life": 5,
			"max_speed": 80,
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
			"max_speed": 8,
			"experience_given": 22,
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
				"min_damage_given": 20,
				"max_damage_given": 20
			}
		}
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

func _ready():
	save_data = SaveData.load_or_create()
	mazo = Mazo.crear(save_data.original_cards)

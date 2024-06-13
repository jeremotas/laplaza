extends Node

var save_data:SaveData

var settings = {
	"game": {
		"init_level": "level",
		"player_goal": 600,
		"enemy_goal": 12,
		"player_max_life": 15,
		"min_player_life_after_level_up": 0,
		"initial_conditions": {
			"units_arrived": 0,
			"life": 15,
			"malon": {
				"granadero": 0,
				"correntino": 0,
				"moreno": 0,
				"husares_infernales": 0
			},
			"level": 0,
			"time": 0
		}
	},
	"patricios": {
		"general": {
			"life": 20,
			"max_speed": 250,
			"attack":{
				"bullet": {
					"speed": 150,
					"duration": 2.0,
				},
				"cooldown": 1,
				"min_damage_given": 1,
				"max_damage_given": 1
			},
			"barrilete_cosmico": {
				"life": 20000000,
				"min_damage_given": 100000,
				"max_damage_given": 100000,
				"max_speed": 400,
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
		"arribeno": {
			"life": 14,
			"max_speed": 150,
			"attack":{
				"bullet": {
					"speed": 200,
					"duration": 0.1,
					"explotion": {
						"duration": 0.75,
						"scale": 22,
						"particle": "escopetazo"
					}
				},
				"cooldown": 1,
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
		}
	},
	"ingleses": {
		"soldado": {
			"life": 1,
			"max_speed": 15,
			"experience_given": 2,
			"attack":{
				"bullet": {
					"speed": 100,
					"duration": 2.0,
				},
				"probability": 50,
				"cooldown": 1,
				"min_damage_given": 1,
				"max_damage_given": 1
			}
		},
		"highlander": {
			"life": 5,
			"max_speed": 8,
			"experience_given": 8,
			"attack":{
				"bullet": {
					"speed": 50,
					"duration": 2.0,
				},
				"cooldown": 2,
				"probability": 80,
				"min_damage_given": 4,
				"max_damage_given": 4
			}
		}
	}
}

func _ready():
	save_data = SaveData.load_or_create()

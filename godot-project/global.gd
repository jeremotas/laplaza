extends Node

var settings = {
	"game": {
		"init_level": "level2",
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
				"bullet_speed": 800,
				"cooldown_attack_time": 0.005,
				"duration": 5
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
						"scale": 20,
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
					"duration": 0.01,
					"explotion": {
						"duration": 0.75,
						"scale": 10,
						"particle": "boleadora"
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
					"speed": 150,
					"duration": 2.0,
				},
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
				"cooldown": 1,
				"min_damage_given": 4,
				"max_damage_given": 4
			}
		}
	},
	"enemy_spawn_strategy":[
		{
			"min_time": 20,
			"max_alive": 10,
			"spawn1": {"unit_type": [{"unit_type":"highlander", "probability": 20}, {"unit_type":"ingles", "probability": 80}], "seconds": 10, "probability": 100},
			"spawn2": {"unit_type": "ingles", "seconds": 7, "probability": 100},
			"spawn3": {"unit_type": "ingles", "seconds": 10, "probability": 100},
			"spawn4": {"unit_type": "ingles", "seconds": 7, "probability": 100},
			"spawn5": {"unit_type": "ingles", "seconds": 10, "probability": 100},
			"spawn6": {"unit_type": "ingles", "seconds": 10, "probability": 100},
			"spawn7": {"unit_type": [{"unit_type":"highlander", "probability": 20}, {"unit_type":"ingles", "probability": 80}], "seconds": 10, "probability": 100},
		},
		{
			"min_time": 60,
			"max_alive": 40,
			"spawn1": {"unit_type": [{"unit_type":"highlander", "probability": 40}, {"unit_type":"ingles", "probability": 60}], "seconds": 8, "probability": 100},
			"spawn2": {"unit_type": "ingles", "seconds": 8, "probability": 90},
			"spawn3": {"unit_type": "ingles", "seconds": 8, "probability": 90},
			"spawn4": {"unit_type": "highlander", "seconds": 8, "probability": 50},
			"spawn5": {"unit_type": "ingles", "seconds": 4, "probability": 50},
			"spawn6": {"unit_type": "ingles", "seconds": 4, "probability": 50},
			"spawn7": {"unit_type": [{"unit_type":"highlander", "probability": 40}, {"unit_type":"ingles", "probability": 60}], "seconds": 8, "probability": 100},
		},
		{
			"min_time": 180,
			"max_alive": 60,
			"spawn1": {"unit_type": [{"unit_type":"highlander", "probability": 30}, {"unit_type":"ingles", "probability": 70}], "seconds": 4, "probability": 100},
			"spawn2": {"unit_type": "ingles", "seconds": 4, "probability": 90},
			"spawn3": {"unit_type": "ingles", "seconds": 4, "probability": 90},
			"spawn4": {"unit_type": "highlander", "seconds": 8, "probability": 70},
			"spawn5": {"unit_type": "ingles", "seconds": 4, "probability": 80},
			"spawn6": {"unit_type": "ingles", "seconds": 4, "probability": 80},
			"spawn7": {"unit_type": "ingles", "seconds": 4, "probability": 80},
		},
		{
			"min_time": 300,
			"max_alive": 80,
			"spawn1": {"unit_type": "highlander", "seconds": 3, "probability": 70},
			"spawn2": {"unit_type": "ingles", "seconds": 3, "probability": 40},
			"spawn3": {"unit_type": "ingles", "seconds": 4, "probability": 95},
			"spawn4": {"unit_type": "ingles", "seconds": 3, "probability": 40},
			"spawn5": {"unit_type": "ingles", "seconds": 3, "probability": 70},
			"spawn6": {"unit_type": "ingles", "seconds": 3, "probability": 70},
			"spawn7": {"unit_type": "highlander", "seconds": 3, "probability": 70},
		},
		{
			"min_time": 540,
			"max_alive": 100,
			"spawn1": {"unit_type": "ingles", "seconds": 1.5, "probability": 40},
			"spawn2": {"unit_type": "highlander", "seconds": 2, "probability": 30},
			"spawn3": {"unit_type": "ingles", "seconds": 2, "probability": 40},
			"spawn4": {"unit_type": "highlander", "seconds": 2, "probability": 30},
			"spawn5": {"unit_type": "highlander", "seconds": 1.5, "probability": 40},
			"spawn6": {"unit_type": "ingles", "seconds": 1.5, "probability": 40},
			"spawn7": {"unit_type": "highlander", "seconds": 1.5, "probability": 40},
		}
	]
}

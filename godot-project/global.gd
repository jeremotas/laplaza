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
		}
	},
	"enemy_spawn_strategy":[
		{
			"min_time": 0,
			"spawn1": {"unit_type": "ingles", "seconds": 10, "probability": 100, "max_alive": 10},
			"spawn2": {"unit_type": "ingles", "seconds": 7, "probability": 100, "max_alive": 10},
			"spawn3": {"unit_type": "ingles", "seconds": 10, "probability": 100, "max_alive": 10},
			"spawn4": {"unit_type": "ingles", "seconds": 7, "probability": 100, "max_alive": 10},
			"spawn5": {"unit_type": "ingles", "seconds": 10, "probability": 100, "max_alive": 10},
			"spawn6": {"unit_type": "ingles", "seconds": 10, "probability": 100, "max_alive": 10},
			"spawn7": {"unit_type": "ingles", "seconds": 10, "probability": 100, "max_alive": 10},
		},
		{
			"min_time": 20,
			"spawn1": {"unit_type": "ingles", "seconds": 4, "probability": 50, "max_alive": 40},
			"spawn2": {"unit_type": "ingles", "seconds": 8, "probability": 90, "max_alive": 40},
			"spawn3": {"unit_type": "ingles", "seconds": 8, "probability": 90, "max_alive": 40},
			"spawn4": {"unit_type": "ingles", "seconds": 8, "probability": 90, "max_alive": 40},
			"spawn5": {"unit_type": "ingles", "seconds": 4, "probability": 50, "max_alive": 40},
			"spawn6": {"unit_type": "ingles", "seconds": 4, "probability": 50, "max_alive": 40},
			"spawn7": {"unit_type": "ingles", "seconds": 4, "probability": 50, "max_alive": 40},
		},
		{
			"min_time": 60,
			"spawn1": {"unit_type": "ingles", "seconds": 4, "probability": 80, "max_alive": 60},
			"spawn2": {"unit_type": "ingles", "seconds": 4, "probability": 90, "max_alive": 60},
			"spawn3": {"unit_type": "ingles", "seconds": 4, "probability": 90, "max_alive": 60},
			"spawn4": {"unit_type": "ingles", "seconds": 4, "probability": 90, "max_alive": 60},
			"spawn5": {"unit_type": "ingles", "seconds": 4, "probability": 80, "max_alive": 60},
			"spawn6": {"unit_type": "ingles", "seconds": 4, "probability": 80, "max_alive": 60},
			"spawn7": {"unit_type": "ingles", "seconds": 4, "probability": 80, "max_alive": 60},
		},
		{
			"min_time": 120,
			"spawn1": {"unit_type": "ingles", "seconds": 3, "probability": 70, "max_alive": 80},
			"spawn2": {"unit_type": "ingles", "seconds": 3, "probability": 40, "max_alive": 80},
			"spawn3": {"unit_type": "ingles", "seconds": 4, "probability": 95, "max_alive": 80},
			"spawn4": {"unit_type": "ingles", "seconds": 3, "probability": 40, "max_alive": 80},
			"spawn5": {"unit_type": "ingles", "seconds": 3, "probability": 70, "max_alive": 80},
			"spawn6": {"unit_type": "ingles", "seconds": 3, "probability": 70, "max_alive": 80},
			"spawn7": {"unit_type": "ingles", "seconds": 3, "probability": 70, "max_alive": 80},
		},
		{
			"min_time": 180,
			"spawn1": {"unit_type": "ingles", "seconds": 1.5, "probability": 40, "max_alive": 100},
			"spawn2": {"unit_type": "ingles", "seconds": 2, "probability": 30, "max_alive": 100},
			"spawn3": {"unit_type": "ingles", "seconds": 2, "probability": 40, "max_alive": 100},
			"spawn4": {"unit_type": "ingles", "seconds": 2, "probability": 30, "max_alive": 100},
			"spawn5": {"unit_type": "ingles", "seconds": 1.5, "probability": 40, "max_alive": 100},
			"spawn6": {"unit_type": "ingles", "seconds": 1.5, "probability": 40, "max_alive": 100},
			"spawn7": {"unit_type": "ingles", "seconds": 1.5, "probability": 40, "max_alive": 100},
		}
	]
}

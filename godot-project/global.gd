extends Node

var settings = {
	"game": {
		"player_goal": 600,
		"enemy_goal": 12,
		"player_max_life": 15,
		"min_player_life_after_level_up": 0,
		"initial_conditions": {
			"units_arrived": 0,
			"life": 10,
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
			"min_damage_given": 5,
			"max_damage_given": 5,
			"max_speed": 250,
			"bullet_speed": 150,
			"cooldown_attack_time": 1,
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
			"min_damage_given": 4,
			"max_damage_given": 4,
			"max_speed": 100,
			"bullet_speed": 150,
			"cooldown_attack_time": 1
		},
		"moreno": {
			"life": 14,
			"min_damage_given": 2,
			"max_damage_given": 2,
			"max_speed": 150,
			"bullet_speed": 150,
			"cooldown_attack_time": 0.7
		},
		"correntino": {
			"life": 3,
			"min_damage_given": 8,
			"max_damage_given": 14,
			"max_speed": 50,
			"bullet_speed": 500,
			"cooldown_attack_time": 5
		},
		"husares_infernales": {
			"life": 100,
			"min_damage_given": 50,
			"max_damage_given": 50,
			"max_speed": 300,
			"bullet_speed": 300,
			"cooldown_attack_time": 0.1
		}
	},
	"ingleses": {
		"soldado": {
			"life": 8,
			"min_damage_given": 1,
			"max_damage_given": 2,
			"max_speed": 15,
			"bullet_speed": 150,
			"cooldown_attack_time": 1,
			"experience_given": 2
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
		},
		{
			"min_time": 20,
			"spawn1": {"unit_type": "ingles", "seconds": 4, "probability": 50, "max_alive": 40},
			"spawn2": {"unit_type": "ingles", "seconds": 8, "probability": 90, "max_alive": 40},
			"spawn3": {"unit_type": "ingles", "seconds": 8, "probability": 90, "max_alive": 40},
			"spawn4": {"unit_type": "ingles", "seconds": 8, "probability": 90, "max_alive": 40},
			"spawn5": {"unit_type": "ingles", "seconds": 4, "probability": 50, "max_alive": 40},
		},
		{
			"min_time": 60,
			"spawn1": {"unit_type": "ingles", "seconds": 4, "probability": 80, "max_alive": 60},
			"spawn2": {"unit_type": "ingles", "seconds": 4, "probability": 90, "max_alive": 60},
			"spawn3": {"unit_type": "ingles", "seconds": 4, "probability": 90, "max_alive": 60},
			"spawn4": {"unit_type": "ingles", "seconds": 4, "probability": 90, "max_alive": 60},
			"spawn5": {"unit_type": "ingles", "seconds": 4, "probability": 80, "max_alive": 60},
		},
		{
			"min_time": 120,
			"spawn1": {"unit_type": "ingles", "seconds": 3, "probability": 70, "max_alive": 80},
			"spawn2": {"unit_type": "ingles", "seconds": 3, "probability": 40, "max_alive": 80},
			"spawn3": {"unit_type": "ingles", "seconds": 4, "probability": 95, "max_alive": 80},
			"spawn4": {"unit_type": "ingles", "seconds": 3, "probability": 40, "max_alive": 80},
			"spawn5": {"unit_type": "ingles", "seconds": 3, "probability": 70, "max_alive": 80},
		},
		{
			"min_time": 180,
			"spawn1": {"unit_type": "ingles", "seconds": 1.5, "probability": 40, "max_alive": 100},
			"spawn2": {"unit_type": "ingles", "seconds": 2, "probability": 30, "max_alive": 100},
			"spawn3": {"unit_type": "ingles", "seconds": 2, "probability": 40, "max_alive": 100},
			"spawn4": {"unit_type": "ingles", "seconds": 2, "probability": 30, "max_alive": 100},
			"spawn5": {"unit_type": "ingles", "seconds": 1.5, "probability": 40, "max_alive": 100},
		}
	]
}

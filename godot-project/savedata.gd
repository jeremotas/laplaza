class_name SaveData extends Resource

@export var lagrimas_acumuladas:int = 0
@export var master_mixer:float = 1.0
@export var music_mixer:float = 1.0
@export var efectos_mixer:float = 1.0

@export var original_cards = [
	# Unidades
	{"name": "granadero", "quantity": 5},
	{"name": "correntino", "quantity": 0},
	{"name": "arribeno", "quantity": 3},
	{"name": "moreno", "quantity": 0},
	# Eventos
	{"name": "ataque_husares_infernales", "quantity": 0},
	{"name": "barrilete_cosmico", "quantity": 0}, 
	# Trucos
	{"name": "ollas_del_pueblo", "quantity": 0},
	{"name": "upgrade_life", "quantity": 5} 	
]



const SAVE_PATH:String = "user://la_furia_de_las_trenzas.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)
	
static func load_or_create() -> SaveData:
	var res:SaveData
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as SaveData
	else: 
		res = SaveData.new()
	return res


class_name SaveData extends Resource

@export var lagrimas_acumuladas:int = 0
@export var master_mixer:float = 1.0
@export var music_mixer:float = 1.0
@export var efectos_mixer:float = 1.0

@export var mejoras = {
	"correntinos":0,
	"arribenos":0,
	"granaderos":0,
	"morenos":0,
	"cartas_por_mano": 3
}

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


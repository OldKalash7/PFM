extends Resource


# Esta clase / resource representa una savegame y contiene lo siguiente
#
# Game Version --> para identificar en que versión del juego se hizo la save
#
# Una estructura con la información de los nodos para reconstruir la escena i el estado de juego
# como se encontraba cuando se sale. Data tiene la siguiente estructura
#
# DICTIONARY LEVEL_NAME { ARRAY OF DICTIONARY NODE_URI : {NODE_DATA}, ...  }
#
# Finalmente se guarda la información de SaveGlobals, que se encuentra sobre Main, esta clase
# guarda información global sobre los niveles que se han visitado, el nivel actual etc... De manera que al reconstruir la partida se pueda determinar si que nivel se ha de cargar, si un nivel se entra por primera vez etc...


class_name SaveFile

const  GLOBALS_NAME : String = "GLOBALS"
export (String) var game_version : String
export (Dictionary) var data : Dictionary
var current_save : bool
var level_name : String


func initialize(level_name : String) -> void:
	data[level_name] = {}

	
func set_current_save(current : bool) -> void:
	current_save = current


func set_level_name(level_name : String) -> void:
	self.level_name = level_name

	
func store_data(node_data : Dictionary) -> void:
	data[level_name] = node_data
	print(data[level_name]["current_player_instance_"])


func retrieve_data(uri : String) -> Dictionary:
	return data[level_name][uri]
	


func store_globals(globals_data : Dictionary) -> void:
	data[GLOBALS_NAME] = globals_data


func retrieve_globals() -> Dictionary:
	return data[GLOBALS_NAME]

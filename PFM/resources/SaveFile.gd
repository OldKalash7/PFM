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
const GAME_STATE_MANAGER : String = "GAME_STATE_MANAGER"

export (String) var game_version : String
export (Dictionary) var data : Dictionary



## STORE DATA FUNCTIONS ##

# Store data generic function
func store_data(node_uri : String,node_data : Dictionary) -> void:
	data[node_uri] = node_data	


# Store the content of SaveGlobals
func store_globals(globals_data : Dictionary) -> void:
	data[GLOBALS_NAME] = globals_data


# Store the content of GameStateManager
func store_game_state(game_state_data : Dictionary) -> void:
	data[GAME_STATE_MANAGER] = game_state_data


## RETRIEVE DATA FUNCTIONS ##


# Retrieve data from of a node based on the URI of the node
func retrieve_data(uri : String) -> Dictionary:
	return data[uri]


# Retrieve  data of SaveGlobals
func retrieve_globals() -> Dictionary:
	return data[GLOBALS_NAME]


# Retrieve GameStateManager data
func retrieve_game_state() -> Dictionary:
	return data[GAME_STATE_MANAGER]

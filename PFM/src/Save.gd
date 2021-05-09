extends Node


class_name Save

# Utils
var savegame_date : String
var slot_inddex : int
# Almacena los datos cargados del savegame en formato diccionario
var savegame_dic : Dictionary
var current_level
# Almacena información acerca de los niveles que el jugador ya ha visitado
var visited_levels : Array


# Constructor
func _init():
	pass


func load(level_name : String, game_state_instance : Node ) -> Node:
	# Preparar el nivel
	var new_level =  load("res://scenes/levels/" + level_name + ".tscn").instance()

	# Determinar si ya se ha visitado ese nivel
	if !visited_levels.has(level_name):
		# El nivel ya ha sido visitado, llamar a su funcion de carga pasandole su diccionario
		# correpondiente
		if new_level.has_method("load"):
			new_level.load(savegame_dic["level_name"])
		else:
			print("DEBUG SAVE SYSTEM --> El nivel " + level_name + " no tiene funcion de carga")
		return new_level
	else:
		# Devolver una nueva instancia, no se ha estado aun en ese nivel

		# Crear una nueva instancia del nivel
		
		return new_level
	
func save() -> void:
	

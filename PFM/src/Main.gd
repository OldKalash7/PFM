extends Node



const save_path : String = "res://savegame.dat"

onready var EVENTS_LIST : Events = Events.new()
onready var EVENTS_GAME : GameEvents = GameEvents.new()

func exit() -> void:
	get_tree().quit()




func change_scene() -> void:
	pass

func save_game() -> void:
	
	# Recuperar todos los nodos que esten en el grupo de persistencia

	var nodes = get_tree().get_nodes_in_group("persistencia")

	# Abrir el archivo
	var file = File.new()
	file.open(save_path,File.WRITE)

	# Iterar por los nodos y llamar a su método de guardado
	for node in nodes:
		if node.has_method("save"):
			var save_dictionary = node.save()




func get_node_by_name(nodes : Array, node_name : String) -> Node:
	for i in nodes:
		if i.name == node_name:
			return i
	# TODO mirar una solucion mejor que devolver null
	return null

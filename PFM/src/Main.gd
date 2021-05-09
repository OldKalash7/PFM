extends Node



const save_path : String = "res://savegame.dat"
const levels_path : String = "res://scenes/levels/"
#onready var current_save : String = "test_sav.tres"

onready var EVENTS_LIST : Events = Events.new()
onready var EVENTS_GAME : GameEvents = GameEvents.new()
onready var SAVE_SYSTEM : SaveSystem = SaveSystem.new()
onready var SAVE_GLOBALS : SaveGlobals = SaveGlobals.new()

var levels : Dictionary 


func exit() -> void:
	get_tree().quit()




func change_scene() -> void:
	pass

func get_save_instance() -> SaveSystem:
	return SAVE_SYSTEM

func save_game(version : String) -> void:
	
	# Recuperar todos los nodos que esten en el grupo de persistencia
	#var nodes = get_tree().get_nodes_in_group("persistencia")
	# Abrir el archivo
	#var file = File.new()
	#file.open(save_path,File.WRITE)
	# Iterar por los nodos y llamar a su método de guardado
	#for node in nodes:
	#	if node.has_method("save"):
	#		var save_dictionary = node.save()
	#SAVE_SYSTEM.save(version)
	pass


func load_game(version : String) -> void:
	pass


func get_level_by_name(level_name : String) -> Resource:
	var level = load(levels_path + level_name + ".tscn")
	return level


func get_node_by_name(nodes : Array, node_name : String) -> Node:
	for i in nodes:
		if i.name == node_name:
			return i
	# TODO mirar una solucion mejor que devolver null
	return null

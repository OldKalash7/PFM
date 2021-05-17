extends Node



const SAVE_PATH_FOLDER : String = "res://debug/saves/"
const LEVELS_PATH : String = "res://scenes/levels/"
#onready var current_save : String = "test_sav.tres"

onready var EVENTS_LIST : Events = Events.new()
onready var EVENTS_GAME : GameEvents = GameEvents.new()
onready var SAVE_GLOBALS : SaveGlobals = SaveGlobals.new()

var levels : Dictionary 



func _init():

	_load_levels()


func exit() -> void:
	get_tree().quit()


func change_scene() -> void:
	pass


func get_level_by_name(level_name : String) -> Resource:
	var level = load(LEVELS_PATH + level_name + ".tscn")
	return level


func get_node_by_name(nodes : Array, node_name : String) -> Node:
	for i in nodes:
		if i.name == node_name:
			return i
	# TODO mirar una solucion mejor que devolver null
	return null


func _load_levels() -> void:
	var dir : Directory = Directory.new()

	dir.open(LEVELS_PATH)

	if dir.open(LEVELS_PATH) == OK:
		dir.list_dir_begin()

		var file_name = dir.get_next()

		while file_name != "":
			if !dir.current_is_dir():
				levels[file_name.get_basename()] = LEVELS_PATH + file_name
			file_name = dir.get_next()
		dir.list_dir_end()

	

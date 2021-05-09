extends Node


# se encarga de guardar algunos parametros globales para
class_name SaveGlobals

var URI : String = "current_save_globals_" + name
# The levels the player has already visited.
# if the player attempts to travel to a level he has been on previously
# it will trigger a load process 
var visited_levels : Array
# The level the player is playing currently
var current_level : String




func is_level_visited(level_name : String) -> bool:
	return visited_levels.find(level_name) != -1


func visit_level(level_name : String) -> void:
	visited_levels.append(level_name)


func update_current_level(level_name : String) -> void:
	current_level = level_name


func save(save_file : Resource) -> void:
	var save_dic : Dictionary

	save_dic['visited_levels'] = visited_levels
	save_dic['current_level'] = current_level

	save_file.data[URI] = save_dic


func load(save_file : Dictionary) -> void:
	var save_dic : Dictionary = save_file.data[URI]

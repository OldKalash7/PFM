extends Node


# se encarga de guardar algunos parametros globales para
class_name SaveGlobals

var URI : String = "current_save_globals_" + name
# The levels the player has already visited.
# if the player attempts to travel to a level he has been on previously
# it will trigger a load process 
var visited_levels : Array

# Data of the levels the player visits for persistence
var visited_levels_data : Dictionary

# The level the player is playing currently
var current_level : String


func _init():
	Main.EVENTS_LIST.connect("level_entered",self,"_level_entered")


func _level_entered(level_name : String) -> void:
	# Update new current level
	current_level =  level_name

	# If the player has entered the level for te first time
	# store it in visited levels
	if !is_level_visited(level_name):
		visit_level(level_name)
	


func is_level_visited(level_name : String) -> bool:
	return visited_levels.find(level_name) != -1


func visit_level(level_name : String) -> void:
	visited_levels.append(level_name)


# Store data of the level for persistance
func store_level_data(level_name : String, level_data : Array) -> void:
	visited_levels_data[level_name] = level_data

	
# Retrieve level data for persistance
func retrieve_level_data(level_name : String) -> Dictionary:
	if visited_levels_data.has(level_name):
		return visited_levels_data[level_name]
	else:
		return {}


############################################################################
# LOAD AND SAVE FUNCTIONS #
############################################################################
func save(save_file : Resource) -> void:
	var save_dic : Dictionary

	save_dic['visited_levels'] = visited_levels
	save_dic['current_level'] = current_level

	save_file.store_globals(save_dic)


func load_globals(save_file : Resource) -> void:
	var save_dic : Dictionary = save_file.retrieve_globals()

	visited_levels = save_dic['visited_levels'] 
	current_level = save_dic['current_level']

extends State


class_name GameState


# Refrence for the GamesChangePool, tasked with the storage of changes to delay
# triggering when entering the level in which the change has to be made.
var game_change_pool : GameChangePool
var save_dictionary : Dictionary
# List of already made changes.
var activated_changes : Array

var changes : Dictionary

func save_state_changes() -> Dictionary:
	return save_dictionary
	

func load_state_changes(restored_dictionary : Dictionary) -> void:
	save_dictionary = restored_dictionary


func stack_changes() -> void:
	var uri : String
	var level : String
	var list_of_changes : Array
	
	for i in changes.keys():
		uri = i
		if activated_changes.find(uri) == -1:
			level  = changes[i][0]
			list_of_changes = changes[i][1]
			game_change_pool.push_changes(level,uri,list_of_changes)
	

func set_made_changes(made_changes : Array) -> void:
	activated_changes = made_changes


func get_made_changes() -> Array:

	return activated_changes


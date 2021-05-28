extends Node

# Clase base para todos los niveles que da soporte a la navegacion
# y otras funcionalidades


class_name Level


signal level_restored

export (Vector2) var default_spawn_location : Vector2
export (bool) var volatile
var spawn_group : Node
onready var level_name : String = self.filename.replace(self.filename.get_base_dir() + "/","").get_basename()

# Load level as resource
# Execute ready callback of level
# Check if level has been entered
# Restore level if needed
# Ask GameStateManager for changes in the level
# Present the level to the player


func _ready():
	# Init signals and other components
	self.connect("level_restored",self,"_on_level_restored")
	
	
	# Has the level been visited previously?
	if Main.SAVE_GLOBALS.visited_levels.find(level_name) == -1:
		pass
	else:
		match Main.load_mode:
			Main.LOAD_MODES.NEW:
				pass
			Main.LOAD_MODES.RESTORE:
				_restore_level()
			Main.LOAD_MODES.LOAD:
				_load_level_from_save_game()
				GameStateManager.load_state(Main.current_save_file)
		

	spawn_group = get_node("Spawns")
	assert(spawn_group != null)
	# Signal we have entered the level, stored in visited_levels
	Main.EVENTS_LIST.emit_signal("level_entered",level_name)
	initialize()

func _enter_tree():
	pass

# Initialize the level
func initialize() -> void:
	
	# Update GameState
	
	#GameStateManager.update()
	
	# Spawn the player at the desired location
	for spawn in get_node("Spawns").get_children():
		if spawn.spawn_name == Main.spawn_location:
			spawn.spawn()
	
	#get_tree().get_current_scene().get_node("TransitionLayer/Transition").play_in()


# Virtual method for each specific level to do their logic
func update_level() -> void:
	pass

func _restore_level() -> void:
	var restore_nodes : Array = get_tree().get_nodes_in_group("restore")
	var level_data = Main.SAVE_GLOBALS.retrieve_level_data(level_name)
	
	for node in restore_nodes:
		node.restore(level_data[node.name])

	self.emit_signal("level_restored")


# Callback for when the level restoration is completed
func _on_level_restored() -> void:
	print("Level restored")

func on_player_travel_requested(travel : Travel) -> void:
	print("Debug of " + self.name + " Player requested travel from "+ travel.name)

	# Decide if store values or not
	if volatile:
		travel.travel_to()
	else:
		_store_level()
		travel.travel_to()

func _store_level() -> void:
	var store_nodes : Array = get_tree().get_nodes_in_group("restore")
	var nodes_content_dictionary : Dictionary
	
	for node in store_nodes:
		nodes_content_dictionary[node.name] = node.store()
		
	# Save the level data on save globals
	Main.SAVE_GLOBALS.store_level_data(level_name,nodes_content_dictionary)


func _load_level_from_save_game() -> void:
	var save_file : SaveFile = Main.current_save_file
	var nodes_to_load : Array = get_tree().get_nodes_in_group("persist")
	
	for node in nodes_to_load:
		if node.has_method("load"):
			node.load(save_file)
			
	# RESET del load mode para volver al restore de los niveles
	Main.load_mode = Main.LOAD_MODES.RESTORE

extends Node

# Clase principal para controlar el guardado y la carga de archivos
# Se encarga de guardar y cargar en disco todos los datos de guardado

class_name SaveSystem


const SAVE_RESOURCE = preload("res://resources/SaveFile.gd")
const STATE_POOL_NAME = "STATE_POOL_CHANGES"
#const SAVE_FOLDER : String = "res://debug/saves/"
# var SAVE_NAME : String = "_sav.tres"


func _ready():

	# Connect signals
	Main.EVENTS_LIST.connect("save_game",self,"save")
	Main.EVENTS_LIST.connect("load_game",self,"load_level")
	

# SAVING PROCESS

# 1: Save signal is emmitted
# 2: Initialize a new save resource file
# 3: Get the version from the project settings
# 4: Call all the nodes in the tree that are in the group persist, pass the resource, and store the save_dictionary
# 5: Store the globals such as the current level name and the array of visited levels
	
func save(version : String) -> void:

	assert(SAVE_RESOURCE != null)

	# Ready SaveFile resource
	var save_game : SaveFile = SAVE_RESOURCE.new()

	# Get game Version
	save_game.game_version = ProjectSettings.get_setting("application/config/Version")
	
	# Call all nodes in persist group
	for node in get_tree().get_nodes_in_group("persist"):
		if node.has_method("save"):
			print(node.URI)
			# Every node in the persist group saves their data in a dictionary and then,
			# stores that dictionary on the save_file data dictionary using the URI of their
			# node as a Key to acces the values.
			node.save(save_game)
		else:
			print("SAVE SYSTEM DEBUG --> El nodo con nombre " + node.name + " no tiene funcion save()")

	# Save SaveGlobals
	Main.SAVE_GLOBALS.save(save_game)

	# SAVE THE POOL OF CHANGES
	#GameStateManager.save_pool_changes(STATE_POOL_NAME)
	# Save GameStateManager
	GameStateManager.save(save_game)

	# Create directories if needed
	var directory : Directory = Directory.new()
	if !directory.dir_exists(Main.SAVE_PATH_FOLDER):
		directory.make_dir_recursive(Main.SAVE_PATH_FOLDER)

	# Get save path
	#var save_path : String = SAVE_FOLDER.plus_file("%" + SAVE_NAME % version)
	var save_path : String = Main.SAVE_PATH_FOLDER.plus_file(version + ".tres")
	# Save file and get possible error during saving
	var error := ResourceSaver.save(save_path, save_game)
	# If there is an error while saving, log it to debug
	if error != OK:
		print("SAVE SYSTEM DEBUG --> FALLO AL INTENTAR GUARDAR EL SIGUIENTE ARCHIVO: \n\n")
		print("PATH -> " + save_path)
		print("ERROR -> " + error as String)


func load(version : String) -> void:
	# Get path
	var save_path : String = Main.SAVE_PATH_FOLDER.plus_file(version)
	
	var f : File = File.new()
	# Check if the files exists
	if !f.file_exists(save_path):
		print("SAVE SYSTEM DEBUG --> FALLO AL INTENTAR CARGAR EL SIGUIENTE ARCHIVO: \n\n")
		print("PATH -> " + save_path)
	else:
		# Load the resource in the file
		var save_game : Resource = load(save_path)
		# Delegate loading to each node present
		for node in get_tree().get_nodes_in_group("persist"):
			node.load(save_game)



# Returns a instance of a previously visited level, as such, first loads the content		
func load_level(savegame_path : String) -> void:

	print("DEBUG" + savegame_path)
	# Retrieve savegame
	var savegame : Resource = load(Main.SAVE_PATH_FOLDER + savegame_path)
	# Set Main to load mode to prevent restore of the levels
	Main.load_mode = Main.LOAD_MODES.LOAD
	# Retrieve save globals
	Main.SAVE_GLOBALS.load_globals(savegame)
	# LOAD THE POOL OF CHANGES
	#GameStateManager.load_pool_changes(STATE_POOL_NAME)
	# Retrieve GameStatemanager
	GameStateManager.load_state(savegame)
	# Set the current save file
	Main.current_save_file = savegame

	
	# DELEGAR ESTO AL NIVEL 
	var level : Resource = load_level_from_disk(Main.levels[Main.SAVE_GLOBALS.current_level])
	get_tree().change_scene_to(level)


func load_level_from_disk(path : String) -> Resource:
	return load(path)

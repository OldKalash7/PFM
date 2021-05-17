extends Node

# Clase principal para controlar el guardado y la carga de archivos
# Se encarga de guardar y cargar en disco todos los datos de guardado

class_name SaveSystem


const SAVE_RESOURCE = preload("res://resources/SaveFile.gd")
const SAVE_FOLDER : String = "res://debug/saves/"
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

	# Initialize resource

	save_game.set_level_name(Main.SAVE_GLOBALS.current_level)
	
	# Get game Version
	save_game.game_version = ProjectSettings.get_setting("application/config/Version")
	
	# Call all nodes in persist group
	for node in get_tree().get_nodes_in_group("persist"):
		if node.has_method("save"):
			# Every node in the persist group saves their data in a dictionary and then,
			# stores that dictionary on the save_file data dictionary using the URI of their
			# node as a Key to acces the values.
			node.save(save_game)
		else:
			print("SAVE SYSTEM DEBUG --> El nodo con nombre " + node.name + " no tiene funcion save()")

	# Save SaveGlobals

	Main.SAVE_GLOBALS.save(save_game)

	var directory : Directory = Directory.new()
	# Create directories if needed
	if !directory.dir_exists(SAVE_FOLDER):
		directory.make_dir_recursive(SAVE_FOLDER)

	# Get save path
	#var save_path : String = SAVE_FOLDER.plus_file("%" + SAVE_NAME % version)
	var save_path : String = SAVE_FOLDER.plus_file(version + ".tres")
	# Save file and get possible error during saving
	var error := ResourceSaver.save(save_path, save_game)
	# If there is an error while saving, log it to debug
	if error != OK:
		print("SAVE SYSTEM DEBUG --> FALLO AL INTENTAR GUARDAR EL SIGUIENTE ARCHIVO: \n\n")
		print("PATH -> " + save_path)
		print("ERROR -> " + error as String)


func load(version : String) -> void:
	# Get path
	var save_path : String = SAVE_FOLDER.plus_file(version)
	
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
func load_level(savegame_path : String) -> Node:

	print("DEBUG" + savegame_path)
	# Retrieve savegame
	var savegame : Resource = load(Main.SAVE_PATH_FOLDER + savegame_path)

	# Retrieve save globals
	Main.SAVE_GLOBALS.load_globals(savegame)

	# Set the current level for the savefile
	savegame.set_level_name(Main.SAVE_GLOBALS.current_level)

	# Get the path for the level from the list of levels in Main
	print("DEBUG PATH " +Main.levels[Main.SAVE_GLOBALS.current_level])

	var level : Node = load_level_from_disk(Main.levels[Main.SAVE_GLOBALS.current_level]).instance()
	var nodes_to_load : Array = level.get_children()

	# Ejecutar los metodos de carga en cada nodo del nivel
	# Trigger load in the tree
	
	if level.is_in_group("persist"):
		level.load(savegame)
		
	for node in nodes_to_load:
		if node.is_in_group("persist"):
			node.load(savegame)

	# Eliminar escena actual y cargar la nueva	
	get_tree().get_current_scene().queue_free()
	get_tree().get_root().add_child(level)
	
	
	return level


func load_level_from_disk(path : String) -> Resource:
	return load(path)



## Load level data of a level 

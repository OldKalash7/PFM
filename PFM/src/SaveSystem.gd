extends Node

# Clase principal para controlar el guardado y la carga de archivos
# Se encarga de guardar y cargar en disco todos los datos de guardado

class_name SaveSystem


const SAVE_RESOURCE = preload("res://resources/SaveFile.gd")
const SAVE_FOLDER : String = "res://debug/saves/"
var SAVE_NAME : String = "_sav.tres"


func _ready():
	pass
	

func save(version : String) -> void:
	assert(SAVE_RESOURCE != null)
	# Ready SaveFile resource
	var save_game : SaveFile = SAVE_RESOURCE.new()

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

	var directory : Directory = Directory.new()
	# Create directories if needed
	if !directory.dir_exists(SAVE_FOLDER):
		directory.make_dir_recursive(SAVE_FOLDER)

	# Get save path
	#var save_path : String = SAVE_FOLDER.plus_file("%" + SAVE_NAME % version)
	var save_path : String = SAVE_FOLDER.plus_file(version + SAVE_NAME)
	# Save file and get possible error during saving
	var error := ResourceSaver.save(save_path, save_game)
	# If there is an error while saving, log it to debug
	if error != OK:
		print("SAVE SYSTEM DEBUG --> FALLO AL INTENTAR GUARDAR EL SIGUIENTE ARCHIVO: \n\n")
		print("PATH -> " + save_path)
		print("ERROR -> " + error as String)


func load(version : String) -> void:
	# Get path
	var save_path : String = SAVE_FOLDER.plus_file(SAVE_NAME % version)
	
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

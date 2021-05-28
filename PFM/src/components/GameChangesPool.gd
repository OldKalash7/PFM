extends Node


class_name GameChangePool


var changes : Dictionary


func _ready():
	Main.EVENTS_LIST.connect("level_entered",self,"pop_changes")
	
	
	
func push_changes(level_name : String, changes : Array) -> void:
	self.changes[level_name] = changes
	print('pushed changes')
	
	
func pop_changes(level_name : String) -> void:
	if self.changes.has(level_name):
		var level_changes : Array = changes[level_name]
	
		for i in level_changes:
			i.call_func()
			level_changes.remove(level_changes.find(i))

func save_changes(name_of_the_save_file : String) -> void:

	# Store the data of the changes for reloading
	var f = File.new()
	print()
	var error =f.open(Main.SAVE_PATH_FOLDER.plus_file(name_of_the_save_file + ".sav"),File.WRITE)
	print(error)
	
	f.store_var(changes,true)
	f.close()
	

func load_changes(name_of_the_save_file : String) -> void:
	var f = File.new()
	f.open(Main.SAVE_PATH_FOLDER.plus_file(name_of_the_save_file).plus_file(".sav"),File.READ)
	self.changes = f.get_var(true)
	f.close
	

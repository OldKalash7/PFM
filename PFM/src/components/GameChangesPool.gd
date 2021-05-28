extends Node


class_name GameChangePool


signal changed_made(uri)

var changes : Dictionary


func _ready():
	Main.EVENTS_LIST.connect("level_entered",self,"pop_changes")
	
	
	
func push_changes(level_name : String, uri : String,changes : Array) -> void:
	self.changes[level_name] = [uri,changes]
	print('pushed changes')
	
	
func pop_changes(level_name : String) -> void:
	
	if self.changes.has(level_name):
		
		if !changes[level_name].empty():
		
			var uri : String = changes[level_name][0]
			print(uri)
			var list_of_changes : Array = changes[level_name][1]
		
			for i in list_of_changes:
				i.call_func()
				
			emit_signal("changed_made",uri)
			changes[level_name] = []

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
	

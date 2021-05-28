extends Node


class_name GameChangePool


var changes : Dictionary

func _ready():
	Main.EVENTS_LIST.connect("level_entered",self,"pop_changes")
	
	
	
func push_changes(level_name : String, changes : Array) -> void:
	self.changes[level_name] = changes
	
	
func pop_changes(level_name : String) -> void:
	if self.changes.has(level_name):
		var level_changes : Array = changes[level_name]
	
		for i in level_changes:
			i.call_func()
			level_changes.remove(level_changes.find(i))



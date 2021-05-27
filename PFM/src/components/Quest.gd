extends Node2D


class_name Quest


signal quest_created(quest)
signal quest_updated(quest_tree_node, quest_status)


enum STATUS {CREATED = 0, ASSIGNED = 1, HOLD = 2, COMPLETED = 3, FAILED = 4}


var quest_uri : String
var quest_objective : String
var quest_status : int
var quest_description : String

func _init(name : String, objective : String, description : String):
	quest_status = STATUS.CREATED
	self.quest_uri = name 
	self.quest_objective = objective
	self.quest_description = description
	
	



func save() -> void:
	pass
	

func load() -> void:
	pass

extends Node


class_name QuestFactory


var _quest_resource : Resource = preload("res://scenes/components/Quest.tscn") 
	

static func make_quest(quest_raw_file_path : String) -> Quest:
	
	var file = File.new()
	var parsed_quest_file : Dictionary 
	
	# Parse the json quest raw file
	file.open(quest_raw_file_path, File.READ)
	parsed_quest_file = parse_json(file.get_as_text())
	file.close()
	
	# Assemble the quest and return the object
	# name : String, objective : String, description : String
	
	return Quest.new(parsed_quest_file['name'],parsed_quest_file['objective'], parsed_quest_file['description'])
	

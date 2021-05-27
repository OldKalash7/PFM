extends State


class_name GameStateFindKey


func enter( args : Dictionary) -> void:
	unlock_doors()
	# Launch new quest
	get_node("QuestActionable").action()

func exit() -> void:
	pass


func update() -> void:
	pass


func unlock_doors() -> void:
	var travel_nodes : Array = get_tree().get_nodes_in_group("travel")
	
	for travel in travel_nodes:
		
		if !travel.name == "HallExteriorDoor":
			travel.enabled = true
			travel.dialog_mode = false

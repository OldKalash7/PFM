extends State


class_name GameStateBeginning


export (String,FILE, "*.json") var doors_loocked_dialog : String
export (String,FILE, "*.json") var hall_exterior_door_dialog : String
export (String) var start_quest_name : String
var game_change_pool : GameChangePool

func enter( args : Dictionary) -> void:
	Main.EVENTS_GAME.connect("change_to_find_key",self,"_on_key_found")
	game_change_pool = get_parent().get_node("GameChangesPool")
	
	# Activate quest
	# funcref(obj, "say_hello")
	game_change_pool.push_changes('bedroom',[funcref(self,"activate_quest")])
	game_change_pool.push_changes('hall',[funcref(self,"lock_doors")])

func exit() -> void:
	pass


func update() -> void:
	if Main.SAVE_GLOBALS.current_level == "bedroom" && !GameStateManager.is_quest_active(start_quest_name):
		get_tree().get_current_scene().get_node("QuestActionableGotoDoor").action()
		
	if Main.SAVE_GLOBALS.current_level == "hall":
		lock_doors()



func lock_doors() -> void:
	var travel_nodes : Array = get_tree().get_nodes_in_group("travel")
	
	for travel in travel_nodes:
		travel.enabled = false
		if travel.name == "HallExteriorDoor":
			travel.get_node("DialogueActionable").change_dialog(hall_exterior_door_dialog)
		else:
			travel.get_node("DialogueActionable").change_dialog(doors_loocked_dialog)
		travel.dialog_mode = true


func activate_quest() -> void:
	get_tree().get_current_scene().get_node("QuestActionableGotoDoor").action()

func _on_key_found() -> void:
	GameStateManager.change_state_to("FindKey",{})

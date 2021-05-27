extends State


class_name GameStateFindKey


const exit_house_quest_name : String = "go_outside"
const locked_drawer_dialog : String = "res://assets/dialogs/locked_drawer.json"

var _dialog_drawer_changed : bool
var _first_note_found : bool
var _second_note_found : bool
var _third_note_found : bool

func enter( args : Dictionary) -> void:
	_dialog_drawer_changed = false
	unlock_doors()
	# Launch new quest
	get_node("FindKeyQuest").action()
	GameStateManager.change_quest_status(exit_house_quest_name, Quest.STATUS.HOLD)

func exit() -> void:
	pass


func update() -> void:
	if Main.SAVE_GLOBALS.current_level == 'dinning':
		get_tree().get_current_scene().get_node("Objects/Drawer/DialogueActionable").change_dialog(locked_drawer_dialog )


func unlock_doors() -> void:
	var travel_nodes : Array = get_tree().get_nodes_in_group("travel")
	
	for travel in travel_nodes:
		
		if !travel.name == "HallExteriorDoor":
			travel.enabled = true
			travel.dialog_mode = false

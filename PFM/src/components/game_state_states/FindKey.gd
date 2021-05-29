extends GameState


class_name GameStateFindKey


const exit_house_quest_name : String = "go_outside"
const locked_drawer_dialog : String = "res://assets/dialogs/locked_drawer.json"


func _ready():
	# Name the state
	state_name = name
	# Reference for game_change_pool
	game_change_pool = get_parent().get_node("GameChangesPool")
	# Connect signals
	Main.EVENTS_GAME.connect("key_found",self,"_on_key_found")
	
	# Init list of changes
	changes = {
	'drawer_dialog' : ['dinning',[funcref(self,"put_drawer_dialog")]]
	}

func enter( args : Dictionary) -> void:
	print('enter find key')
	stack_changes()
	unlock_doors()
	
	# Launch new quest
	get_node("FindKeyQuest").action()
	GameStateManager.change_quest_status(exit_house_quest_name, Quest.STATUS.HOLD)

func put_drawer_dialog() -> void:
	get_tree().get_current_scene().get_node("Items/Drawer").get_node("DialogueActionable").change_dialog(locked_drawer_dialog)
	pass
	
func unlock_doors() -> void:
	var travel_nodes : Array = get_tree().get_nodes_in_group("travel")
	
	for travel in travel_nodes:
		
		if !travel.name == "HallExteriorDoor":
			travel.enabled = true
			travel.dialog_mode = false


func _on_key_found() -> void:
	GameStateManager.change_state_to("FindCodes",{})

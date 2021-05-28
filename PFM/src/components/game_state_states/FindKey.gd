extends State


class_name GameStateFindKey


const exit_house_quest_name : String = "go_outside"
const locked_drawer_dialog : String = "res://assets/dialogs/locked_drawer.json"
const book_note_dialog : String = "res://assets/dialogs/found_code_library.json"
const book_kitchen_dialog : String = "res://assets/dialogs/found_code_kitchen.json"

const NUMBER_OF_NOTES : int = 3
var _dialog_drawer_changed : bool
var codes_found_counter : int
var game_change_pool : GameChangePool

func enter( args : Dictionary) -> void:
	_dialog_drawer_changed = false
	game_change_pool = get_parent().get_node("GameChangesPool")
	unlock_doors()
	# Launch new quest
	get_node("FindKeyQuest").action()
	GameStateManager.change_quest_status(exit_house_quest_name, Quest.STATUS.HOLD)
	Main.EVENTS_GAME.connect("change_to_exit_house",self,"_on_change_to_exit_house")
	Main.EVENTS_GAME.connect("found_code",self,"_on_found_code")
	
	game_change_pool.push_changes('library',[funcref(self,"put_library_dialog")])
	game_change_pool.push_changes('kitchen',[funcref(self,"put_kitchen_dialog")])

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



func put_library_dialog() -> void:
	get_tree().get_current_scene().get_node("Items/Book").get_node("DialogueActionable").change_dialog(book_note_dialog)
	
func put_kitchen_dialog() -> void:
	get_tree().get_current_scene().get_node("Items/Book").get_node("DialogueActionable").change_dialog(book_kitchen_dialog)
	
	
func put_dinning_dialog() -> void:
	pass
	
	
func _on_change_to_exit_house() -> void:
	GameStateManager.change_state_to("ExitHouse",{})
	

func _on_found_code() -> void:
	codes_found_counter += 1
	
	if codes_found_counter == 3:
		# Update drawer dialog to allow key pick up
		pass

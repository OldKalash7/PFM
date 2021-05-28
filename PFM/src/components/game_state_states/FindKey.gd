extends GameState


class_name GameStateFindKey


const exit_house_quest_name : String = "go_outside"
const locked_drawer_dialog : String = "res://assets/dialogs/locked_drawer.json"
const book_note_dialog : String = "res://assets/dialogs/found_code_library.json"
const book_kitchen_dialog : String = "res://assets/dialogs/found_code_kitchen.json"
const NUMBER_OF_NOTES : int = 3
var codes_found_counter : int


func _ready():
	# Name the state
	state_name = name
	# Reference for game_change_pool
	game_change_pool = get_parent().get_node("GameChangesPool")
	# Connect signals
	Main.EVENTS_GAME.connect("change_to_exit_house",self,"_on_change_to_exit_house")
	Main.EVENTS_GAME.connect("found_code",self,"_on_found_code")
	
	# Init list of changes
	changes = {
	'library_code' : ['library',[funcref(self,"put_library_dialog")]],
	'kitchen_code' : ['kitchen',[funcref(self,"put_kitchen_dialog")]]
	}

func enter( args : Dictionary) -> void:
	stack_changes()
	unlock_doors()
	# Launch new quest
	get_node("FindKeyQuest").action()
	GameStateManager.change_quest_status(exit_house_quest_name, Quest.STATUS.HOLD)

	
	#game_change_pool.push_changes('library',[funcref(self,"put_library_dialog")])
	#game_change_pool.push_changes('kitchen',[funcref(self,"put_kitchen_dialog")])

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

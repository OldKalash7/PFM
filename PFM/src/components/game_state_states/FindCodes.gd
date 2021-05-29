extends GameState



const NUMBER_OF_NOTES : int = 3
var codes_found_counter : int
const book_note_dialog : String = "res://assets/dialogs/found_code_library.json"
const book_kitchen_dialog : String = "res://assets/dialogs/found_code_kitchen.json"
const code_dinning_dialog : String = "res://assets/dialogs/found_code_dinning.json"


func _ready():
		# Name the state
	state_name = name
	# Reference for game_change_pool
	game_change_pool = get_parent().get_node("GameChangesPool")
	# Connect signals
	Main.EVENTS_GAME.connect("found_code",self,"_on_found_code")
	

	changes = {
	'library_code' : ['library',[funcref(self,"put_library_dialog")]],
	'kitchen_code' : ['kitchen',[funcref(self,"put_kitchen_dialog")]],
	}


func enter( args : Dictionary) -> void:
	put_dinning_dialog()
	stack_changes()


func put_library_dialog() -> void:
	get_tree().get_current_scene().get_node("Items/BookLibrary").get_node("DialogueActionable").change_dialog(book_note_dialog)
	
func put_kitchen_dialog() -> void:
	get_tree().get_current_scene().get_node("Items/BookKitchen").get_node("DialogueActionable").change_dialog(book_kitchen_dialog)
		
func put_dinning_dialog() -> void:
	get_tree().get_current_scene().get_node("Items/BookDinning").get_node("DialogueActionable").change_dialog(code_dinning_dialog)
	


func _on_found_code() -> void:
	codes_found_counter += 1
	print('codes found')
	
	if codes_found_counter == 3:
		# Change dialog of the drawer to found
		# 'dinning_code' : ['dinning',[funcref(self,"put_dinning_dialog")]]
		GameStateManager.change_state_to("FoundKey",{})
			#game_change_pool.stack_single_change({'unlocked_hall_door' : ['dinning',[funcref(self,"put_drawer_unlocked_dialog")]]})
		

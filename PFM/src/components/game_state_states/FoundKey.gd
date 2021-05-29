extends GameState


class_name FoundKey


const unlocked_drawer_dialog : String = "res://assets/dialogs/drawer_unlocked.json"

func _ready():
	# Name the state
	state_name = name
	# Reference for game_change_pool
	game_change_pool = get_parent().get_node("GameChangesPool")
	# Connect signals
	Main.EVENTS_GAME.connect("key_taken",self,"_on_key_taken")

	# Init list of changes
	changes = {
	'drawer_dialog_unlocked' : ['dinning',[funcref(self,"put_drawer_unlocked_dialog")]],
	}


func enter( args : Dictionary) -> void:
	if Main.SAVE_GLOBALS.current_level == "dinning":
		put_drawer_unlocked_dialog()
		changes.erase('drawer_dialog_unlocked')
	else:
		stack_changes()


func put_drawer_unlocked_dialog() -> void:
	get_tree().get_current_scene().get_node("Items/Drawer").get_node("DialogueActionable").change_dialog(unlocked_drawer_dialog)

func _on_key_taken() -> void:
	GameStateManager.change_state_to("ExitHouse",{})

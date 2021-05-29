extends GameState


class_name GameStateExitHouse


const unlocked_door_dialog = "res://assets/dialogs/house_door_unlocked.json"


func _ready():
		# Name the state
	state_name = name
	# Reference for game_change_pool
	game_change_pool = get_parent().get_node("GameChangesPool")
	# Connect signals
	Main.EVENTS_GAME.connect("trigger_leave_cutscene",self,"_on_trigger_leave_cutscene")
	
	# Init list of changes
	changes = {
	'change_unlocked_dialog_door' : ['hall',[funcref(self,"put_exterior_door_dialog")]],
	}


func enter( args : Dictionary) -> void:
	stack_changes()
	

func exit() -> void:
	pass


func update() -> void:
	pass


func put_exterior_door_dialog() -> void:
	get_tree().get_current_scene().get_node("HallExteriorDoor/DialogueActionable").change_dialog(unlocked_door_dialog)

func _on_trigger_leave_cutscene() -> void:
	get_tree().change_scene("res://scenes/cutscenes/Credits.tscn")


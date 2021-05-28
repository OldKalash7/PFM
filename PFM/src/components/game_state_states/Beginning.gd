extends State


class_name GameStateBeginning


export (String,FILE, "*.json") var doors_loocked_dialog : String
export (String,FILE, "*.json") var hall_exterior_door_dialog : String
export (String) var start_quest_name : String
var game_change_pool : GameChangePool

var activated_changes : Array


onready var changes : Dictionary = {
	'activate_go_outside_quest' : ['bedroom',[funcref(self,"activate_quest")]],
	'lock_doors' : ['hall',[funcref(self,"lock_doors")]]
}

func _ready():
	state_name = name
	game_change_pool = get_parent().get_node("GameChangesPool")
	get_parent().get_node("GameChangesPool").connect("changed_made",self,"_on_change_made")
func enter( args : Dictionary) -> void:
	#  Connect signals
	Main.EVENTS_GAME.connect("change_to_find_key",self,"_on_key_found")
	
	for i in changes.keys():
		var uri : String = i
		var level : String = changes[i][0]
		var list_of_changes = changes[i][1]
		game_change_pool.push_changes(level,uri,list_of_changes)
		
	#game_change_pool.push_changes('bedroom',[funcref(self,"activate_quest")])
	#game_change_pool.push_changes('hall',[funcref(self,"lock_doors")])

func exit() -> void:
	pass


func update() -> void:
	pass

func get_made_changes() -> Array:
	return activated_changes
	
	
func stack_changes() -> void:
	var uri : String
	var level : String
	var list_of_changes : Array
	
	for i in changes.keys():
		uri = i
		if activated_changes.find(uri) == -1:
			level  = changes[i][0]
			list_of_changes = changes[i][1]
			game_change_pool.push_changes(level,uri,list_of_changes)
	
func set_made_changes(made_changes : Array) -> void:
	activated_changes = made_changes

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


func _on_change_made(name_of_the_change : String) -> void:
	activated_changes.append(name_of_the_change)
	print("ACTIVATED CHANGES --> ")
	print( activated_changes)

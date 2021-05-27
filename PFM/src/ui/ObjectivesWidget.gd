extends Control


class_name ObjectivesWidget


var objectives_tree_control : Tree
var tree_nodes : Array


func _ready():
	# Init, create root and hide it
	objectives_tree_control = get_node("MarginContainer/Tree")

	
	#var test1 = objectives_tree_control.create_item(root)
	#var test2 = objectives_tree_control.create_item(test1)
	#root.set_text(0,"CURRENT OBJECTIVES")
	#test1.set_text(0,"Get outside")
	#test2.set_text(0,"Get outside the house")

	show_in_screen(false)
	


	
func refresh_objective() -> void:
	
	var quest_info : Dictionary = GameStateManager.get_current_quest_info()
	var root
	
	objectives_tree_control.clear()
	
	root = objectives_tree_control.create_item()
	objectives_tree_control.hide_root = true
	
	
	for i in quest_info.keys():
		var objective_tree = objectives_tree_control.create_item(root)
		var description_tree = objectives_tree_control.create_item(objective_tree)
		objective_tree.set_text(0,quest_info[i][0])
		description_tree.set_text(0,quest_info[i][1])
	


func _on_open() -> void:
	refresh_objective()
	show_in_screen(true)

func _input(event) -> void:
	if Input.is_action_just_pressed("tab"):
		_on_open()
	elif Input.is_action_just_released("tab"):
		show_in_screen(false)

func show_in_screen(show : bool) -> void:
	self.visible = show

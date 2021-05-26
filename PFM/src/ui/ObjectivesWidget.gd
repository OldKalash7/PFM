extends Control


class_name ObjectivesWidget


var objectives_tree_control : Tree
var tree_nodes : Array


func _ready():
	objectives_tree_control = get_node("MarginContainer/Tree")
	var root = objectives_tree_control.create_item()
	objectives_tree_control.hide_root = true
	var test1 = objectives_tree_control.create_item(root)
	var test2 = objectives_tree_control.create_item(test1)
	root.set_text(0,"CURRENT OBJECTIVES")
	test1.set_text(0,"Get outside")
	test2.set_text(0,"Get outside the house")

	show_in_screen(false)
	

func remove_objective(objective) -> void:
	pass
	
func append_objective(objective) -> void:
	pass
	
func clear_objectives() -> void:
	pass
	

func _input(event) -> void:
	if Input.is_action_pressed("tab"):
		show_in_screen(true)
	elif Input.is_action_just_released("tab"):
		show_in_screen(false)

func show_in_screen(show : bool) -> void:
	self.visible = show

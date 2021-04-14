extends Node


class_name Dialog

enum DIALOG_STATES {DISPLAYING, IDLE, IDLE_DECISION,FINISHED, PAUSED}

var _current_state 
var _dialog_tree : Dictionary
var _current_entrie : Dictionary
var _dialog_pointer : int



func _init(dialog_tree):
	_dialog_pointer = 0
	self._dialog_tree = dialog_tree
	self._current_entrie = _dialog_tree[String(_dialog_pointer)]


func _process(delta):
	
	#match[_current_state]
	pass



func set_dialog_tree(dialog_tree : Dictionary) -> void:
	self._dialog_tree = dialog_tree

func set_dialog_pointer(index : int) -> void:
	_dialog_pointer = index
	
func get_current_entrie() -> Dictionary:
	return _current_entrie

func get_current_pointer() -> int:
	return _dialog_pointer

func get_dialog_tree() -> Dictionary:
	return _dialog_tree

func current_entrie_has_choices() -> bool:
	return !_current_entrie["decisiones"].empty()

func get_curent_entrie_line() -> String:
	return _current_entrie["line"]

func advance_entrie() -> void:
	_current_entrie = _dialog_tree[String(_current_entrie["pointer"])]
	_dialog_pointer = _current_entrie["pointer"]

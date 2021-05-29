extends Node


class_name Dialog

const DECISION_POINTER : int = 2
const DECISION_CALLBACKS : int = 1


var _current_state


var _dialog_tree : Dictionary
var _current_entrie : Dictionary
var _dialog_pointer : int
var _finished : bool
var _repeating : bool

# Constructor

func _init(dialog_tree):
	_dialog_pointer = 0
	self._dialog_tree = dialog_tree
	if dialog_tree.has(String(_dialog_pointer)):
		self._current_entrie = _dialog_tree[String(_dialog_pointer)]
	_finished = false



# Métodos públicos

func is_repeating() -> bool:
	return _repeating
	
func set_repeat(repeat : bool) -> void:
	_repeating = repeat

func has_finished() -> bool:
	return _finished

func set_dialog_tree(dialog_tree : Dictionary) -> void:
	self._dialog_tree = dialog_tree
	
func set_finished(finished : bool) -> void:
	self._finished = finished

func set_dialog_pointer(index : int) -> void:
	_dialog_pointer = index
	
func get_current_entrie() -> Dictionary:
	return _current_entrie
	
func set_current_entrie(new_entrie : Dictionary) -> void:
	_current_entrie = new_entrie

func get_current_entrie_decisions() -> Dictionary:
	return _current_entrie.get("decisiones")

func get_name_for_current_display() -> String:
	return _current_entrie.get("display") + "Display"

func get_current_pointer() -> int:
	return _dialog_pointer

func get_dialog_tree() -> Dictionary:
	return _dialog_tree


func is_repeated_mode() -> bool:
	
	# Repted mode es una flag que tiene la ultima entrie de dialogo y indica
	# si se va mostrar en bucle por pantalla la opción repetida
	if get_current_pointer() == -1:
		return _current_entrie["repeat"] == true
	else:
		return false

func is_restart_mode_on() -> bool:
	if get_current_pointer() == -1:
		return _current_entrie["restart"] == true
	else:
		return false
	
func restart() -> void:
	_finished = false
	_current_entrie = _dialog_tree["0"]
	_dialog_pointer = 0

	

func current_entrie_has_choices() -> bool:
	return _current_entrie["type"] == "decision"
		

# Devuelve todas las callbacks de una entrada normal
func get_entrie_callbacks() -> Array:
	return _current_entrie["callbacks"]

# Devuelve las callbacks de una decision de una entrada de tipo decision
func get_entrie_callbacks_for_decision(decision_index) -> Array:
		return _current_entrie["decisiones"][decision_index as String][DECISION_CALLBACKS]



func get_curent_entrie_line() -> String:
	return _current_entrie["line"]

func advance_entrie() -> void:
	# TODO revisar esto
	_current_entrie = _dialog_tree[String(_current_entrie["pointer"])]
	# TOOD cambiar dialog pointer, creo que no es necesario deberia irse fuera
	if _current_entrie['type'] != "decision":
		_dialog_pointer = _current_entrie["pointer"]
	
	if _dialog_pointer == -1:
		_finished = true

# Situa el pointer a la entrada especifica de una decision
func advance_specific_entrie(decision_index : int) -> void:

	_current_entrie = _dialog_tree[String((_current_entrie["decisiones"][String(decision_index)][DECISION_POINTER] ))]
	_dialog_pointer = _current_entrie["pointer"]
	if _dialog_pointer == -1:
		_finished = true

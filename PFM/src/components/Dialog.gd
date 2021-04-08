extends Node


class_name Dialog

enum DIALOG_STATES {DISPLAYING, IDLE, IDLE_DECISION,FINISHED, PAUSED}

var _current_state 
var _dialog_tree : Dictionary
var _current_entrie : Dictionary
var _dialog_pointer : int


func _ready():
    pass

func _init(dialog_tree):
    self._dialog_tree = dialog_tree

func _process(delta):
    
    #match[_current_state]
    pass



func set_dialog_tree(dialog_tree : Dictionary) -> void:
    self._dialog_tree = dialog_tree

func get_current_entrie() -> Dictionary:
    return _current_entrie

func get_current_pointer() -> int:
    return _dialog_pointer

func get_dialog_tree() -> Dictionary:
    return _dialog_tree


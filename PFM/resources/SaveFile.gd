extends Resource


class_name SaveFile


export (String) var game_version : String
export (Dictionary) var data : Dictionary
var current_save : bool


func set_current_save(current : bool) -> void:
	current_save = current

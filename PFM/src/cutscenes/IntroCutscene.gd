extends Node2D


class_name IntroCutscene

var actionable : Actionable
export (String) var transition_to_level: String

func _ready():
	actionable = get_node("DialogueActionable")
	Main.EVENTS_LIST.connect("dialog_finished",self, "_finish_cutscene")
	
	_start_custscene()

func _start_custscene() -> void:
	actionable.action()
	

func _finish_cutscene() -> void:
	get_tree().change_scene_to(load(Main.levels[transition_to_level]))

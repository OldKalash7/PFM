extends State


class_name GameStateExitHouse



func enter( args : Dictionary) -> void:
	Main.EVENTS_GAME.connect("trigger_leave_cutscene",self,"_on_trigger_leave_cutscene")

func exit() -> void:
	pass


func update() -> void:
	pass


func _on_trigger_leave_cutscene() -> void:
	get_tree().change_scene("res://scenes/cutscenes/Credits.tscn")


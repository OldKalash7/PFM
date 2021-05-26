extends Node


# Controla y gestiona el estado del juego y su avance


var quests : Array
var states : Node


func _ready():
	states = get_node("States")
	
	
func change_state_to(state_to_enter) -> void:
	# Exit old state
	# Enter new state
	pass


# Similar to process or update 
func update_state() -> void:
	pass




# SAVE / LOAD FUNCTIONS
	
func save(save_game : SaveFile) -> void:
	pass


func load_state(save_game : SaveFile) -> void:
	pass 

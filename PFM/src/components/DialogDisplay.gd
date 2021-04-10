extends Control

signal choice_selected(choice_id)
signal line_displayed

class_name DialogDisplay




func _ready():
	set_process_unhandled_key_input(false)


# Pinta la linea en pantalla
func display(character_name : String, line : String) -> void:
	pass


# Muestra diferentes elecciones por pantalla en aquellas entradas de dialogo que tenga
func display_choices(choices_list : Array) -> void:
	pass


# Procesa el input para el caso de las decisiones
func _unhandled_key_input(event) -> void:
	pass

extends Node

# Clase base para todos los niveles que da soporte a la navegacion
# y otras funcionalidades

class_name Level

# Nodo para la navegacion
var navegacion : Navigation2D
# Nodo para el personaje
var character : KinematicBody2D


# Inicializacion

func _ready():
	navegacion = $Navegacion
	character = $Player


# Registrar input del raton

func _unhandled_input(event) -> void:

	if event is InputEventMouseButton && (event.button_index == BUTTON_LEFT && event.pressed):
		
		if navegacion != null and character != null:

			var new_path = navegacion.get_simple_path(character.global_position,event.global_position)

			assert(character != null)

			character.set_path(new_path)
		


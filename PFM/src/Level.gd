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


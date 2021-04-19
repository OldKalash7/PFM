extends Node


# Clase base de estado para gestión de los dialogos
# Dialog Manager actua como una maquina de estados para procesar
# diferentes tipos de dialogos.

class_name DialogState

var dialog : Dialog
var dialog_entrie : Dictionary
var displays : Array
var display : DialogDisplay
var default_display # TODO


func _ready():
	set_process_input(false)
	
# Funciona a modo de _ready() para el estado
func enter(dialog : Dialog) -> void:
	set_process_input(false)

# Funciona a modo de "destructor", 
func exit() -> void:
	pass


func _input(event) -> void:
	pass


# Función para el procesamiento del dialogo
func process_dialog() -> void:
	print("Override this function")


# Las entradas de dialogo pueden tener nombres de señales preparadas para ser lanzadas una vez procesado el dialogo
# De esta manera, ciertas lineas de dialogo pueden activar evenetos o situaciones, o las decisiones tomadas pueden afectar el entorno
# Una clase por encima ya será la encargada de recoger la señal y procesarla. Patrón OBSERVER pero utilizando el sistema de señales ya 
# implementado en Godot
func process_callbacks() -> void:
	print("Override this function")

# Callback para cuando termina la animación de dibujado de una linea
func on_line_displayed() -> void:
	pass

# Obtiene un array con todos los objetos de tipo Display presentes en el treee
func get_available_displays() -> Array:
	return get_tree().get_nodes_in_group("displays")

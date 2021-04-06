extends Node

# Clase base para las máquinas de estado finito que utiliza el juego
class_name StateMachine

signal changed_to_new_state(state_name)

export var default_state : String
var state_pool : Dictionary
var _state : State

func _ready():
	change_state_to(default_state, {0:"INITAL"})

# Los siguientes callbacks se delegan al State en cuestión,
# De esta manera, se puede gestionar diferentes comportamientos
# en runtime sin tener que programar todos los condicionales en una
# misma clase

func _process(delta : float):
	_state.handle_process(delta)

func _physics_process(delta : float):
	_state.handle_physics_process(delta)

func _input(event):
	_state.handle_input(event)

func _unhandled_input(event):
	_state.handle_unhandled_input(event)

func _unhandled_key_input(event):
	_state.handle_unhandled_key_input(event)


func change_state_to(new_state_name : String, args : Dictionary) -> void:

	# Conseguir el nuevo estado
	var new_state = get_node(new_state_name)
	# Salir del estado anterior
	# Este check es necesario porque la primera vez el state es null
	if _state != null:
		_state.exit()
	# Cambiar el estado y llamar a la función de entrar
	_state = new_state
	_state.enter(args)
	# Emitir señal diciendo que ha entrado en el nuevo estado
	emit_signal("changed_to_new_state",_state.name)

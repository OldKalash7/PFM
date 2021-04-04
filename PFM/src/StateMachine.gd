extends Node

# Clase base para las máquinas de estado finito que utiliza el juego

class_name StateMachine

signal changed_to_new_state(state_name)

var _default_state : State
var _state_pool : StatePool
var _state : State



func _ready():
	pass

# Los siguientes callbacks se delegan al State en cuestión,
# De esta manera, se puede gestionar diferentes comportamientos
# en runtime sin tener que programar todos los condicionales en una
# misma clase

func _process(delta : float):
	pass

func _physics_process(delta : float):
	pass


func _input(event):
	pass

func change_state_to(new_state_name : State, args : Dictionary) -> void:

	# Conseguir el nuevo estado
	var new_state = state_pool.get_state(new_state_name)
	# Salir del estado anterior
	_state.exit()
	# Entrar en el nuevo estado
	_state.enter(args)
	# Emitir señal diciendo que ha entrado en el nuevo estado
	emit_signal("changed_to_new_state",_state.name)


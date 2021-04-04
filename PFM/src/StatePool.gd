extends Node

# TODO - Solo admite que una StateMachine dada en un momento dado, solicite el objeto y lo utilice
# De lo contrario, si dos objetos lo piden y cambian su estado luego entraria en conflicto al guardarlo
# necesita tener una flag que impida este comportamiento.

class_name StatePool

# Diccionario que guarda una relacion de los estados y su nombre

var _states_pool : Dictionary

# Asigna un State por defecto de manera que si se solicita un State que no existe, de vuelva este DefaultState y no NULL
var _default_state : State


func _ready():
	# Inicializar los estados aqui
	pass


func get_state(state_name : String) -> State:
	# Iterar por los estados para recuperar el estado en cuestión
	for i in _states_pool:
		if i.get(0) == state_name and i.get(2) != false:
			i.get(2) = false
			return i.get(1)

	print("No se ha encontrado el State solicitado, pasando DefaultState")
	return _default_state


func return_state(state_name : String) -> void:
	var found : bool = false
	
	for i in _states_pool && !found:
		if i.get(0) == state_name and i.get(2) != true:
			i.get(2) = true
			found = true
			
			
	if !found:
		print("No se ha encontrado el State solicitado, no se ha cambiado nada")



	

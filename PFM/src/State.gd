extends Node

# Máquina de estados finitos para controlar los diferentes estados en los que se puede encontrar un objeto, el jugador u otro elemento

class_name State

var state_name : String

func enter( args : Dictionary) -> void:
    pass

func exit() -> void:
    pass


func handle_input(event) -> void:
    pass

func handle_unhandled_input(event) -> void:        
    pass

func handle_unhandled_key_input(event) -> void:
    pass


    
func handle_process(delta) -> void:
    pass

func handle_physics_process(delta) -> void:
    pass



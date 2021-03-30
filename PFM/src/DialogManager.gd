extends Node2D

# Controla la logica de los dialogos

class_name DialogManager

var registered_observers : Array



var dialog_display : DialogDisplay

func _ready():
	# Referencia al dialog display
	dialog_display = $DialogDisplay

	
	var concrete : ConcreteObserver = ConcreteObserver.new()

	registered_observers.append(concrete)

func on_dialog_completed() -> void:
	dialog_display.set_process_unhandled_key_input(false)
	dialog_display.visible = 0
	print("DialogManager --> DIALOGO COMPLETADO")
	

func on_milestone_reached(milestone) -> void:
	for observer in registered_observers:
		observer.onNotify(self,milestone)

func init_dialog() -> void:
	pass


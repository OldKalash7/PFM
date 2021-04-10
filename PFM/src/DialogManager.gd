extends Node2D

# Controla la logica de los dialogos

class_name DialogManager


var actionable : Actionable


func _ready():

	Main.EVENTS_LIST.connect("dialog_started",self,"on_dialog_started")

	# Desconectar process al inicio
	print("works")


func on_dialog_completed() -> void:

	get_tree().paused = false
	print("DialogManager --> DIALOGO COMPLETADO")
	

func on_dialog_started(new_actionable) -> void:
	print("works")
	self.actionable = new_actionable	
	print(actionable.name)
	
	
	






	

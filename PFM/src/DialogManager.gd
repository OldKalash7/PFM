extends Node2D

# Controla la logica de los dialogos

class_name DialogManager


var dialog_display : DialogDisplay
var actionable : Actionable





func _ready():

	Main.EVENTS_LIST.connect("dialog_started",self,"on_dialog_started")

	# Referencia al dialog display
	dialog_display = $DialogDisplay

	# Desconectar process al inicio
	set_process(false)


func on_dialog_completed() -> void:
	dialog_display.set_process_unhandled_key_input(false)
	dialog_display.visible = 0

	get_tree().paused = false
	print("DialogManager --> DIALOGO COMPLETADO")
	




func init_dialog() -> void:
	pass


func on_dialog_started(actionable) -> void:
	
	self.actionable = actionable	
	print(actionable.name)
	
	
	






	

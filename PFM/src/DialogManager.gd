extends Node2D
# Controla la logica de los dialogos



class_name DialogManager


var dialog_state : Node
var avaliable_states : Node

var actionable : Actionable
var dialog_displays : Array
var choices_displayer : ChoicesDisplayer

func _ready():

	choices_displayer = get_node("ChoiceDisplayer")
	avaliable_states = get_node("States")

	assert (avaliable_states != null)
	assert (choices_displayer != null)


	Main.EVENTS_LIST.connect("dialog_started",self,"on_dialog_started")
	Main.EVENTS_LIST.connect("dialog_finished",self,"on_dialog_started")

	# Get estado inicial
	dialog_state = avaliable_states.get_node("IDLE_STATE")

	print(dialog_state)
	assert (dialog_state != null)
	


# Cambia a un nuevo estado
func transition() -> void:
	
	# Logica de los dialogos aqui

	if actionable.dialog.has_finished():
		print("DIALOGO ACABADO O NO HAY DIALOGO")
	elif actionable.dialog.current_entrie_has_choices():
		print("Este dialogo tiene decisiones")
	else:
		print("Dialogo normal al que le quedan entradas")
		dialog_state = avaliable_states.get_node("NORMAL_STATE")

	dialog_state.enter(actionable.dialog)
	dialog_state.process_dialog()



	# TODO quitar el primer parametro
func on_dialog_started(dialog_item,new_actionable) -> void:
	self.actionable = new_actionable
	Main.EVENTS_LIST.emit_signal("player_pause")
	print("ACTIONABLE NAME --> " + new_actionable.name)

	transition()
	
	




# Called when a dialog is finished, Unpauses player
func on_dialog_finished() -> void:
	Main.EVENTS_LIST.emit_signal("player_resume")

	

extends Node2D
# Controla la logica de los dialogos



class_name DialogManager


var actionable : Actionable
var dialog_displayer : DialogDisplay

func _ready():


	Main.EVENTS_LIST.connect("dialog_started",self,"on_dialog_started")

	# Corregir el posible null pointer TODO con un check null

	dialog_displayer = get_node("DialogDisplayer")

	assert (dialog_displayer != null)

	set_process_input(false)


	
func on_dialog_started(dialog_item,new_actionable) -> void:
	self.actionable = new_actionable
	Main.EVENTS_LIST.emit_signal("player_pause")
	process_dialog()


func process_dialog() -> void:
	# Pausar el jugador

	if actionable.dialog.current_entrie_has_choices():
		print("has_choices")
	elif actionable.dialog.get_current_pointer() != -1:
		dialog_displayer.display("test", actionable.dialog.get_curent_entrie_line())
	else:
		print("Se ha acabado el dialogo")
		dialog_displayer.change_display_visibility(false)
		Main.EVENTS_LIST.emit_signal("player_resume")
	

func _input(event) -> void:
	if Input.is_action_just_released("enter"):
		actionable.dialog.advance_entrie()
		set_process_input(false)
		process_dialog()
	

func on_line_displayed() -> void:
	set_process_input(true)




	

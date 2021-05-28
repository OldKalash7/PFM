extends DialogState


class_name ChoiceDialogState


var choice_displayer : ChoicesDisplayer
onready var timer : Timer = get_node("Timer")


func _ready():

	._ready()

	choice_displayer = get_node("ChoiceDisplayer")
	assert (choice_displayer != null)

	timer.connect("timeout",self,"on_timeout")
	Main.EVENTS_LIST.connect("choice_selected",self,"on_choice_selected")


# Funciona a modo de _ready() para el estado
func enter(dialog : Dialog) -> void:
	Main.EVENTS_LIST.connect("line_displayed",self,"on_line_displayed")
	# Desconectar input
	set_process_input(false)
	# Save entrie
	self.dialog = dialog
	# Get Displays
	displays = get_available_displays()
	# Restart timer
	

# Funciona a modo de "destructor", 
func exit() -> void:
	if Main.EVENTS_LIST.is_connected("line_displayed",self,"on_line_displayed"):
		Main.EVENTS_LIST.disconnect("line_displayed",self,"on_line_displayed")


func process_dialog() -> void:
	
	# Mostrar la linea
	display = Main.get_node_by_name(displays,dialog.get_name_for_current_display())
	display.display(dialog.get_curent_entrie_line())
	yield(Main.EVENTS_LIST,"line_displayed")
	choice_displayer.display_choiches(dialog.get_current_entrie_decisions())
	set_process_input(true)


func process_decision_callbacks(decision_index) -> void:

	var callbacks : Array = dialog.get_entrie_callbacks_for_decision(decision_index)

	# Procesa las callbacks si hay
	if callbacks != null && !callbacks.empty():
		
		for i in callbacks:
			# Procesar
			Main.EVENTS_GAME.emit_signal(i)


# Callback para cuando termina la animación de dibujado de una linea
func on_line_displayed() -> void:
	timer.start()

# Obtiene un array con todos los objetos de tipo Display presentes en el treee
func get_available_displays() -> Array:
	return get_tree().get_nodes_in_group("displays")


# TODO Esto deberia poder arreglarse con un yield pero no funciona
func on_timeout() -> void:
	#choice_displayer.display_choiches(dialog.get_current_entrie_decisions())
	#set_process_input(true)
	pass


func on_choice_selected(index : int) -> void:
	process_decision_callbacks(index)
	dialog.advance_specific_entrie(index)
	Main.EVENTS_LIST.emit_signal("dialog_transition")

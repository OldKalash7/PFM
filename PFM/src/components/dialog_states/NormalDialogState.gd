extends DialogState


class_name NormalDialogState



# Funciona a modo de _ready() para el estado
func enter(dialog: Dialog) -> void:
	Main.EVENTS_LIST.connect("line_displayed",self,"on_line_displayed")
	set_process_input(false)
	# Save entrie
	self.dialog = dialog
	

	# Get Displays
	displays = get_available_displays()


# Funciona a modo de "destructor", 
func exit() -> void:
	if Main.EVENTS_LIST.is_connected("line_displayed",self,"on_line_displayed"):
		Main.EVENTS_LIST.disconnect("line_displayed",self,"on_line_displayed")
	


# Función para el procesamiento del dialogo
func process_dialog() -> void:

	# Obtener display
	display = Main.get_node_by_name(displays,dialog.get_name_for_current_display())

	# Si el display que devuelve es null habria que utilizar un display fallback TODO

	# Escribir el texto en pantalla
	display.display(dialog.get_curent_entrie_line())

	# Procesar los callbacks que contenga



func process_callbacks() -> void:

	var callbacks : Array = dialog.get_entrie_callbacks()

	# Procesa las callbacks si hay
	if callbacks != null && !callbacks.empty():
		
		for callback in callbacks:
			# Procesar
			pass


func _input(event) -> void:
	
	if Input.is_action_pressed("enter"):
		
		# Desconecta el input para que el jugador solo pulse enter una vez
		set_process_input(false)
		
		# Llamar a DialogManager para que se ocupe de la transicion al siguiente estado

		if !dialog.has_finished():
			dialog.advance_entrie()
			Main.EVENTS_LIST.emit_signal("dialog_transition")
		else:
			print("dialogo_acabado")
			
			for i in displays:
				i.hide_text()
			
				Main.EVENTS_LIST.emit_signal("dialog_finished")
		
			
		
		



# Callback para cuando termina la animación de dibujado de una linea
func on_line_displayed() -> void:
	set_process_input(true)


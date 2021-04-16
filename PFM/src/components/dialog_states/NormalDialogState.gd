extends DialogState


class_name NormalDialogState



# Funciona a modo de _ready() para el estado
func enter(dialog: Dialog) -> void:
	
	set_process_input(false)
	# Save entrie
	self.dialog = dialog
	

	# Get Displays
	displays = get_available_displays()


# Funciona a modo de "destructor", 
func exit() -> void:
	pass


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
	if Input.is_action_just_released("enter"):
		# Desconecta el input para que el jugador solo pulse enter una vez
		set_process_input(false)
		# Avanzar la entrada del dialogo en base al puntero de la entrada actual the fuck is that
		dialog.advance_entrie()
		# Llamar a DialogManager para que genere
		print(get_parent().name)
		get_parent().transition()
		



# Callback para cuando termina la animación de dibujado de una linea
func on_line_displayed() -> void:
	set_process_input(true)


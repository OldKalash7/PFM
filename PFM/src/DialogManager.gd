extends Node2D
# Controla la logica de los dialogos



class_name DialogManager


var actionable : Actionable
var dialog_displays : Array

func _ready():

	Main.EVENTS_LIST.connect("dialog_started",self,"on_dialog_started")
	Main.EVENTS_LIST.connect("line_displayed",self,"on_line_displayed")

	# TODO remove esto es solo debug
	dialog_displays = get_tree().get_nodes_in_group("displays")

	assert (dialog_displays != null)

	for i in dialog_displays:
		print(i.name)

	set_process_input(false)



	# TODO quitar el primer parametro
func on_dialog_started(dialog_item,new_actionable) -> void:
	refresh_displays()
	self.actionable = new_actionable
	Main.EVENTS_LIST.emit_signal("player_pause")
	process_dialog()


func process_dialog() -> void:
	# Pausar el jugador
	var display = Main.get_node_by_name(dialog_displays,"PlayerDisplay")

	if actionable.dialog.current_entrie_has_choices():
		print("has_choices")
	elif actionable.dialog.get_current_pointer() != -1:
		#dialog_displayer.display("test", actionable.dialog.get_curent_entrie_line())
		
		display.display("test", actionable.dialog.get_curent_entrie_line())
		#pass
	else:
		print("Se ha acabado el dialogo")
		display.hide_text()
		Main.EVENTS_LIST.emit_signal("player_resume")
	

func _input(event) -> void:
	if Input.is_action_just_released("enter"):
		actionable.dialog.advance_entrie()
		set_process_input(false)
		process_dialog()
	

func on_line_displayed() -> void:
	set_process_input(true)


# Refresca el array que contiene los nodos display activos actualmente en el tree
func refresh_displays() -> void:
	dialog_displays = get_tree().get_nodes_in_group("displays")

	

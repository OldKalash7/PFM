extends Panel


class_name OptionsMenu


signal closed


var save_button_control : Button
var exit_button_control : Button
var res_option_button_control : OptionButton
var vsync_check_button_control : CheckButton

func _ready():
	
	# Init controls
	save_button_control = get_node("VBoxContainer/HBoxContainer3/Guardar")
	exit_button_control = get_node("VBoxContainer/HBoxContainer3/Salir")

	# Connect signals
	save_button_control.connect("pressed",self,"_on_save_pressed")
	exit_button_control.connect("pressed",self,"_on_exit_pressed")
	
	# Hide in screen on init
	show_in_screen(false)
	set_process_input(false)
	



func _input(event):
	if event.is_action_pressed("escape") && visible:
		_on_exit_pressed()
		accept_event()
	


func show_in_screen(show : bool) -> void:
	self.visible = show

func refresh_contents() -> void:
	pass

func store_changes() -> void:
	#ProjectSettings.set_setting("display/window/size/width", 1024)
	#ProjectSettings.set_setting("display/window/size/height", 768)
	pass

# CALLBACKS

func _on_open_options_menu() -> void:
	show_in_screen(true)
	set_process_input(true)
	grab_focus()

func _on_save_pressed() -> void:
	store_changes()

func _on_exit_pressed() -> void:
	show_in_screen(false)
	print('exit')
	set_process_input(false)
	emit_signal("closed")
	#set_process_input(false)

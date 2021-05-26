extends Control


class_name PauseMenu


var continue_control : Button
var save_control : Button
var options_control : Button
var exit_control : Button
var exit_dialog : ConfirmationDialog

func _ready():
	
	# Init UI controls
	continue_control = get_node("Panel/VBoxContainer/Continue")
	save_control =  get_node("Panel/VBoxContainer/Save")
	options_control = get_node("Panel/VBoxContainer/Options")
	exit_control =  get_node("Panel/VBoxContainer/Exit")
	exit_dialog = get_node("ExitDialog")
	# Connect signals
	
	continue_control.connect("pressed",self, "_on_continue_pressed")
	# Connect signal to a sibiling SaveMenu Node
	save_control.connect("pressed",get_parent().get_node("SaveMenu"), "_on_open_save_menu")
	options_control.connect("pressed",get_parent().get_node("OptionsMenu"), "_on_open_options_menu")
	exit_control.connect("pressed",self, "_on_exit_pressed")
	exit_dialog.connect("confirmed",self,"_on_exit_confirmation")

	# Hide panel
	self.visible = false

func _input(event):
	if event.is_action_released("escape") && !get_tree().paused:
		get_tree().paused = true
		self.visible = true
		accept_event()
	elif event.is_action_released("escape") && get_tree().paused:
		get_tree().paused = false
		self.visible = false
		accept_event()

	
func _on_continue_pressed() -> void:
	get_tree().paused = false
	self.visible = false




func _on_options_pressed() -> void:
	print("options pressed")


func _on_exit_pressed() -> void:
	exit_dialog.popup_centered()


func _on_exit_confirmation() -> void:
	Main.exit()

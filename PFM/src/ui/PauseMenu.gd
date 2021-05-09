extends Control


class_name PauseMenu


var continue_control : Button
var save_control : Button
var options_control : Button
var exit_control : Button

#export (NodePath) var save_system_path
var save_system : SaveSystem

func _ready():
	
	# Init UI controls
	continue_control = get_node("Panel/VBoxContainer/Continue")
	save_control =  get_node("Panel/VBoxContainer/Save")
	options_control = get_node("Panel/VBoxContainer/Continue")
	exit_control =  get_node("Panel/VBoxContainer/Continue")
	save_system = get_node("GameSaveSystem")
	# Connect signals
	continue_control.connect("pressed",self, "_on_continue_pressed")
	save_control.connect("pressed",self, "_on_save_pressed")
	options_control.connect("pressed",self, "_on_options_pressed")
	exit_control.connect("pressed",self, "_on_exit_pressed")

	# Hide panel
	self.visible = false

func _unhandled_key_input(event):
	if Input.is_action_pressed("escape") && !get_tree().paused:
		get_tree().paused = true
		self.visible = true
	elif Input.is_action_pressed("escape") && get_tree().paused:
		get_tree().paused = false
		self.visible = false

	
func _on_continue_pressed() -> void:
	print("continue pressed")


func _on_save_pressed() -> void:
	#print(save_instance.name)
	save_system.save("test")
	print("save pressed")


func _on_options_pressed() -> void:
	print("options pressed")


func _on_exit_pressed() -> void:
	print("exit pressed")


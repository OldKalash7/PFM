extends Control


var back_button_control : Control
var exit_button_control : Control


func _ready():
	
	back_button_control = get_node("MarginContainer/BackToMenu")
	exit_button_control = get_node("MarginContainer/Exit")
	
	back_button_control.connect("pressed",self,"_on_back_menu")
	exit_button_control.connect("pressed",self,"_on_exit")
	
	
func _on_exit() -> void:
	Main.exit()
	
func _on_back_menu() -> void:
	pass


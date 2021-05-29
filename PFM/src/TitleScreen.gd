extends Control


var load_menu_control : LoadSaveGameMenu
var menu_list_control : ItemList
var options_menu : OptionsMenu
var exit_dialog : ConfirmationDialog

func _ready():

	# Init controls
	load_menu_control = get_node("LoadMenu")
	menu_list_control = get_node("MenuList")
	options_menu = get_node("OptionsMenu")
	exit_dialog = get_node("ExitDialog")
	
	
	# Connect signals
	menu_list_control.connect("item_activated",self,"_on_item_selected")
	options_menu.connect("closed",self,"_on_options_menu_closed")
	load_menu_control.connect("closed",self,"_on_load_menu_closed")
	exit_dialog.connect("confirmed",self,"_on_Exit")
		

func _on_Exit():
	Main.exit()


# Callbacks

func _on_item_selected(index : int) -> void:

	match index:
		0:
			pass
		1:
			_start_new_game()
		2:
			load_menu_control.open_load_menu()
			set_menu_mouse_filter(true)	
		3:	
			# Show options
			options_menu.show_in_screen(true)
			set_menu_mouse_filter(true)	
		4:
			exit_dialog.popup_centered()
		_:
			pass

func _on_load_game_selected(save_game_name : String) -> void:
	pass
	
	
func _on_options_menu_closed() -> void:
	set_menu_mouse_filter(false)	
	
	
func _start_new_game() -> void:
	# Set restore mode
	Main.load_mode = Main.LOAD_MODES.RESTORE
	get_tree().change_scene("res://scenes/cutscenes/intro.tscn")


func set_menu_mouse_filter(ignore : bool) -> void:
	if ignore:
		menu_list_control.mouse_filter = MOUSE_FILTER_IGNORE
	elif !ignore:
		menu_list_control.mouse_filter = MOUSE_FILTER_PASS
		

func _on_load_menu_closed() -> void:
	set_menu_mouse_filter(false)	

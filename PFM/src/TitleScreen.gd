extends Control

var load_menu_control : LoadSaveGameMenu
var menu_list_control : ItemList

func _ready():

	# Init controls
	load_menu_control = get_node("LoadMenu")
	menu_list_control = get_node("MenuList")

	# Connect signals

	menu_list_control.connect("item_activated",self,"_on_item_selected")
		

func _on_Exit():
	Main.exit()


# Callbacks

func _on_item_selected(index : int) -> void:

	match index:
		2:
			load_menu_control.open_load_menu()
		_:
			pass

func _on_load_game_selected(save_game_name : String) -> void:
	# Get the level the save was me on

	# Load that level

	# Replace / Update nodes with the elements of the save selected

	# Change to the level
	
	pass

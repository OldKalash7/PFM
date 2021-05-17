extends LoadSaveGameMenu


class_name SaveMenu

var save_list_control : ItemList
var back_button_control : Button
var save_button_control : Button
var savegame_line_control : LineEdit

func _ready():

	# Init controls
	save_button_control = get_node("Panel/VBoxContainer/HBoxContainer/Save")
	back_button_control = get_node("Panel/VBoxContainer/HBoxContainer/Atras")
	savegame_line_control = get_node("Panel/VBoxContainer/HBoxContainer/SaveGameName")
	save_list_control = get_node("Panel/VBoxContainer/SaveGamesList")
	
	# Connect signals
	back_button_control.connect("pressed",self,"_on_back_pressed")
	save_button_control.connect("pressed",self,"_on_save_pressed")



# Callbacks


func _on_open_save_menu() -> void:
	# Clear previous list
	
	save_list_control.clear()

	var save_list : Array = refresh_contents()

	for save in save_list:
		save_list_control.add_item(save,null,true)
		
	show_menu(true)
	

func _on_back_pressed() -> void:
	show_menu(false)
	# Remove text from the line edit
	savegame_line_control.clear()


func _on_save_pressed() -> void:
	if !savegame_line_control.text.empty():
		var save_list : Array = refresh_contents()
		var savegame_name = savegame_line_control.text
		
		if save_list.find(savegame_name + ".tres") != -1:
			print("Archivo nuevo")
		
		# Emit signal to save game
		Main.EVENTS_LIST.emit_signal("save_game",savegame_name)
	else:
		print("No se ha especificado un nombre para la savegame")
		

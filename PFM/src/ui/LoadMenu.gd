extends LoadSaveGameMenu


class_name LoadMenu





var load_button_control : Button
var back_button_control : Button
var save_list_control : ItemList


func _ready():
	
	# Init controls
	save_list_control = get_node("Panel/VBoxContainer/SaveGamesList")
	load_button_control = get_node("Panel/VBoxContainer/HBoxContainer/Cargar")
	back_button_control = get_node("Panel/VBoxContainer/HBoxContainer/Atras")

	# Connect signals

	load_button_control.connect("pressed",self,"_on_save_pressed")
	back_button_control.connect("pressed",self,"_on_back_pressed")
	save_list_control.connect("item_activated",self,"_on_item_selected")

	show_menu(false)


# Callbacks

func _on_save_pressed() -> void:
	var item_selected : String = save_list_control.get_item_text(save_list_control.get_selected_items()[0])
	Main.EVENTS_LIST.emit_signal("load_game",_get_path(item_selected))


func _on_item_selected(index : int) -> void:
	pass

func open_load_menu() -> void:
	# Clear previous list
	
	save_list_control.clear()

	var save_list : Array = refresh_contents()

	for save in save_list:
		save_list_control.add_item(save,null,true)

	save_list_control.select(0)
		
	show_menu(true)
	self.grab_focus()
	
func _get_path(item_selected : String) -> String:
	return file_paths[item_selected]

extends Control


class_name LoadSaveGameMenu





func refresh_contents() -> Array:


	var save_list : Array
	
	var dir = Directory.new()

	if dir.open(Main.SAVE_PATH_FOLDER) == OK:
		dir.list_dir_begin()

		var file_name = dir.get_next()

		while file_name != "":
			if !dir.current_is_dir():
				save_list.append(file_name.get_basename())
			file_name = dir.get_next()
		dir.list_dir_end()
		
	return save_list

func show_menu(show : bool) -> void:
	self.visible = show

# Callbacks

func _on_back_pressed() -> void:
	show_menu(false)



	

extends Control


func _ready():
	if !Main.current_save.empty():
		print("hay_save")
	else:
		print("no_hay_save")
		

func _on_Exit():
	Main.exit()



func _on_load_game_selected(save_game_name : String) -> void:
	# Get the level the save was me on

	# Load that level

	# Replace / Update nodes with the elements of the save selected

	# Change to the level
	
	pass

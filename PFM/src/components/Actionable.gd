extends Node


class_name Actionable

# Con esta señal, un nodo tipo DialogManager recogeria el dialogo que se va a mostrar

export(String, FILE, "*.json") var loaded_dialog


var dialog : Dialog


func _ready():

	if loaded_dialog != null:
		dialog = Dialog.new(parse_dialog(loaded_dialog))
		print(dialog)



# Parse a dialogue tree to a GDScript dictionary from a JSON file
func parse_dialog(dialog_file_name : String) -> Dictionary:

	var dialog : Dictionary
	var file = File.new()
	
	file.open(dialog_file_name, File.READ)
	dialog = parse_json(file.get_as_text())
	file.close()
		
	return dialog




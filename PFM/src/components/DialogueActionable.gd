extends Actionable

# Con esta señal, un nodo tipo DialogManager recogeria el dialogo que se va a mostrar

export(String, FILE, "*.json") var raw_dialog_file

var dialog: Dialog


func _ready():
	
	if !raw_dialog_file.empty():
		dialog = Dialog.new(parse_dialog((raw_dialog_file)))


func action() -> void:
	Main.EVENTS_LIST.emit_signal("dialog_started",dialog,self)
	


# Parse a dialogue tree to a GDScript dictionary from a JSON file
func parse_dialog(dialog_file_name : String) -> Dictionary:

	var file = File.new()
	var raw_dialogue : Dictionary
	
	file.open(dialog_file_name, File.READ)
	raw_dialogue = parse_json(file.get_as_text())
	file.close()

	return raw_dialogue
		



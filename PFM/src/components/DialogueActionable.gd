extends Actionable

# Con esta señal, un nodo tipo DialogManager recogeria el dialogo que se va a mostrar

export(String, FILE, "*.json") var raw_dialog_file
onready var URI : String = "dialogue_actionable_instance_" + get_parent().name

var dialog: Dialog
var dialog_loaded : bool

func _ready():
	URI = "dialogue_actionable_instance_" + get_parent().name
	if !raw_dialog_file.empty() && dialog == null:
		dialog = Dialog.new(parse_dialog((raw_dialog_file)))
	
	dialog_loaded = !raw_dialog_file.empty()
	

func action() -> void:
	if dialog_loaded:
		Main.EVENTS_LIST.emit_signal("dialog_started",dialog,self)
		print(self.name)
	


# Parse a dialogue tree to a GDScript dictionary from a JSON file
func parse_dialog(dialog_file_name : String) -> Dictionary:

	var file = File.new()
	var raw_dialogue : Dictionary
	
	file.open(dialog_file_name, File.READ)
	raw_dialogue = parse_json(file.get_as_text())
	file.close()

	return raw_dialogue


func change_dialog(dialog_file_path : String) -> void:
	dialog_loaded = !dialog_file_path.empty()
	if dialog_loaded:
		dialog = Dialog.new(parse_dialog((dialog_file_path)))
		print(URI + ' DIALOG CHANGED')
	

# RESTORE / STORE FUNCTIONS
func restore(restore_values : Dictionary) -> void:
	print("Restore " +  self.name)
	raw_dialog_file = restore_values['raw_dialog_file']
	if restore_values.has("dialog"):
		var restored_dialog = Dialog.new({})
		print('has_dialogue')
		restored_dialog.set_dialog_tree(restore_values['dialog']['dialog_tree'])
		restored_dialog.set_current_entrie(restore_values['dialog']['dialog_entrie'])
		restored_dialog.set_dialog_pointer(restore_values['dialog']['dialog_pointer'])
		print(restore_values['dialog']['dialog_pointer'])
		restored_dialog.set_repeat(restore_values['dialog']['repeating'])
		restored_dialog.set_finished(restore_values['dialog']['dialog_finished'])
		
		dialog = restored_dialog
		
		dialog_loaded = restore_values['dialog_loaded']

func store() -> Dictionary:
	print("Store " + self.name )
	
	var store_dic : Dictionary
	var dialog_stored : Dictionary
	# Store stuff
	store_dic['raw_dialog_file'] = raw_dialog_file
	store_dic['dialog_stored '] = dialog_stored 
	
	if dialog != null:
		dialog_stored['dialog_pointer'] = dialog.get_current_pointer()
		dialog_stored['dialog_entrie'] = dialog.get_current_entrie()
		dialog_stored['dialog_tree'] = dialog.get_dialog_tree()
		dialog_stored['dialog_finished'] = dialog.has_finished()
		dialog_stored['repeating'] = dialog.is_repeating()
		store_dic['dialog'] = dialog_stored
		store_dic['dialog_loaded'] = dialog_loaded
	
	return store_dic
	
	
	
	# Funciones de guardado
func save(save_file : Resource) -> void:
	var save_dic : Dictionary
	var dialog_dic : Dictionary
	
	if dialog != null:
		save_dic['raw_dialog_file'] = raw_dialog_file
	
		save_dic['dialog'] = {
		
			"dialog_tree": dialog.get_dialog_tree(),
			"current_entrie": dialog.get_current_entrie(),
			"dialog_pointer": dialog.get_current_pointer(),
			"finished": dialog.has_finished(),
			"repeating": dialog.is_repeating()
		}
	save_dic['dialog_loaded'] = dialog_loaded
	print(dialog_loaded)
	
	# Store on save_file dictionary
	save_file.store_data(URI,save_dic)
	


func load(save_file : Resource) -> void:
	var save_dic : Dictionary = save_file.retrieve_data(URI)
	var restored_dialog : Dialog = Dialog.new({})
	
	if !save_dic.empty():
		save_dic['raw_dialog_file'] = raw_dialog_file
		#save_dic['dialog_loaded'] = dialog_loaded
		dialog_loaded = true
		print(save_dic['dialog_loaded'])
		
		if save_dic.has('dialog'):
			print('SAVED_DIALOG_LOADED')
			restored_dialog.set_dialog_tree(save_dic['dialog']["dialog_tree"])
			restored_dialog.set_current_entrie(save_dic['dialog']["current_entrie"])
			print("DEBUG --> SAVED ENTRIE ")
			print(save_dic['dialog']["current_entrie"]) 
			print(save_dic['dialog']["dialog_pointer"])
			restored_dialog.set_dialog_pointer(save_dic['dialog']["dialog_pointer"])
			restored_dialog.set_finished(save_dic['dialog']["finished"])
			restored_dialog.set_repeat(save_dic['dialog']["repeating"])
			dialog = restored_dialog
			print(dialog.get_current_pointer())
		

extends Item

func _ready() -> void:
	set_process_unhandled_input(false)

func _on_player_interacts() -> void:
	set_process_unhandled_input(true)


func _on_player_goes_away() -> void:
	set_process_unhandled_input(false)
	print('goes away')


func _unhandled_input(event) -> void:
	if Input.is_action_pressed("enter"):
		if get_node("ColorRect").color == Color(1,1,1):
			get_node("ColorRect").color = Color(0,0,0)
		else:
			get_node("ColorRect").color = Color(1,1,1)
		

# RESTORE / STORE FUNCTIONS
func restore(restore_values : Dictionary) -> void:
	print("Restore " +  self.name)
	get_node("ColorRect").color = restore_values['color']

func store() -> Dictionary:
	print("Store " + self.name )
	var store_dictionary : Dictionary
	#var object_dictionary : Dictionary
	
	# Store stuff
	store_dictionary['color'] = get_node("ColorRect").color
	#object_dictionary[self.name] = store_dictionary
	
	return store_dictionary

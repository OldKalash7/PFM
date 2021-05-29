extends Area2D

# Este compomente permite trasladar al jugador y otros objetos a otros niveles.
# Gestiona la transición entre niveles

class_name Travel


signal player_travel_requested(travel)

var spawn_position : Position2D
export (String) var URI : String 
export (bool) var enabled : bool
export (bool) var volatile : bool
export (bool) var empty_level : bool
export (bool) var dialog_mode : bool
export (String) var travel_to_level : String
export (String) var travel_node : String
export (String) var spawn_name : String
export (NodePath) var transition_path : NodePath
var transition : Transition 

func _ready():
	URI =  "travel_instance_" + name
	self.connect("player_travel_requested",get_tree().get_current_scene(),"on_player_travel_requested")
	self.connect("body_entered",self,"_on_body_enters")
	self.connect("body_exited",self,"_on_body_exits")
	transition  = get_node(transition_path)
	set_process_input(false)

func travel_to() -> void:

	if enabled:
		
		# Play FADE IN ANIMATION
		play_transition()
		

		
		var level : Resource = load(Main.levels[travel_to_level])


		# The player has already visited
		if Main.SAVE_GLOBALS.visited_levels.find(travel_to_level) != -1 && !empty_level:
			#var level_data : Dictionary = get_level_data()
			# Load the level data
			pass
			#if level.is_in_group("store"):
			#	level.restore(level_data[level.URI])

			#for node in level.get_children():
			#	if node.is_in_group("store"):
			#		node.restore(level_data[node.URI])
			
		#get_tree().get_current_scene().queue_free()
		Main.spawn_location = spawn_name
		yield(transition,"transintion_finished")
		get_tree().change_scene_to(level)


func play_transition() -> void:
	assert (transition != null)
	transition.play_in()


func disable() -> void:
	enabled = false
	
	
func enable() -> void:
	enabled = true


func save_level_data() -> void:
	var store_nodes : Array = get_tree().get_nodes_in_group("store")
	var level_store_dic : Dictionary
	
	for node in store_nodes:
		if node.has_method("store"):
			level_store_dic[Main.SAVE_GLOBALS.current_level] += node.store()

	#Main.SAVE_GLOBALS.store_level_data(Main.SAVE_GLOBALS.current_level,level_store_dic)


func get_level_data() -> Dictionary:
	return Main.SAVE_GLOBALS.retrieve_level_data(travel_to_level)

func _on_body_enters(body) -> void:
	# Filter player
	if body.name == "Player":
		set_process_input(true)
		
func _on_body_exits(body) -> void:
	if body.name == "Player":
		set_process_input(false)

func _input(event) -> void:
	if Input.is_action_pressed("enter") && enabled:
		emit_signal("player_travel_requested",self)
		print('player request travel')
	elif Input.is_action_pressed("enter") && dialog_mode:
		print("dialog_mode")
		set_process_input(false)
		get_node("DialogueActionable").action()
	


# SAVE / LOAD AND STORE FUNCTIONS 


func save(save_file : Resource) -> void:
	var save_dic : Dictionary

	save_dic['enabled'] = enabled
	save_dic['dialog_mode'] = dialog_mode
	save_dic['spawn_name'] = spawn_name
	save_dic['travel_to_level'] = travel_to_level
	save_dic['transition_path'] = transition_path
	
	# Store on save_file dictionary
	save_file.store_data(URI,save_dic)


func load(save_file : Resource) -> void:
	var save_dic : Dictionary = save_file.retrieve_data(URI)

	if !save_dic.empty():
		enabled = save_dic['enabled']
		dialog_mode = save_dic['dialog_mode']
		spawn_name = save_dic['spawn_name']
		travel_to_level = save_dic['travel_to_level']
		transition_path = save_dic['transition_path']
		
		
# RESTORE / STORE FUNCTIONS
func restore(restore_values : Dictionary) -> void:
	print("Restore " +  self.name)
	enabled = restore_values['enabled']
	dialog_mode = restore_values['dialog_mode']
	spawn_name = restore_values['spawn_name']
	travel_to_level = restore_values['travel_to_level']
	transition_path = restore_values['transition_path']
	

func store() -> Dictionary:
	print("Store " + self.name )
	
	var store_dic : Dictionary
	
	# Store stuff
	store_dic['enabled'] = enabled
	store_dic['dialog_mode'] = dialog_mode
	store_dic['spawn_name'] = spawn_name
	store_dic['travel_to_level'] = travel_to_level
	store_dic['transition_path'] = transition_path
	
	
	return store_dic

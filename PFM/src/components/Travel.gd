extends Area2D

# Este compomente permite trasladar al jugador y otros objetos a otros niveles.
# Gestiona la transición entre niveles

class_name Travel

var spawn_position : Position2D
export(String) var URI : String
export (bool) var enabled : bool
export (bool) var volatile : bool
export (bool) var empty_level : bool
export (String) var travel_to_level : String
export (String) var travel_node : String
export (String) var spawn_name : String
export (NodePath) var transition_path : NodePath
var transition : Transition 

func _ready():
	self.connect("body_entered",self,"_on_body_enters")
	self.connect("body_exited",self,"_on_body_exits")
	transition  = get_node(transition_path)
	set_process_input(false)

func travel_to() -> void:

	if enabled:
		# Play FADE IN ANIMATION
		#play_transition()

		# Decide to store the information of this level or not
		if !volatile:
			#save_level_data()
			pass
			
		# Load a new instance of the level
		#var level : Node = load(Main.levels[travel_to_level]).instance()
		var level : Resource = load(Main.levels[travel_to_level])
		#yield(transition,"transintion_finished")
		
		
		# If the player is visiting a new level or we want a to reinitialize a level
		if Main.SAVE_GLOBALS.visited_levels.find(travel_to_level) == -1 || empty_level:
			print("visiting for the first time")

		# The player has already visited
		elif Main.SAVE_GLOBALS.visited_levels.find(travel_to_level) != -1 && !empty_level:
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
		get_tree().change_scene_to(level)


func play_transition() -> void:
	assert (transition != null)
	transition.play_in()


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
	if Input.is_action_pressed("enter"):
		travel_to()

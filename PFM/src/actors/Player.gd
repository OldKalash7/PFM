extends Actor

signal entered_level
signal player_ready(self_instance)

export (String) var URI = "current_player_instance_" + name
# const UID : String = "PLAYER" # TODO no hace falta porque ya tenemos el nombre de la "clase" de gdscript

# Determina el camino que realizara el personaje
# var path  = PoolVector2Array() 


class_name Player

var linear_velocity : Vector2


func _ready():
	
	# Desconectar physics process, no hay path que procesar
	set_physics_process(false)
	load_data()
	#$StateMachine._state = $StateMachine/IdleState
	Main.EVENTS_LIST.connect("player_pause",self,"on_player_pause")
	Main.EVENTS_LIST.connect("player_resume",self,"on_player_resume")
	Main.EVENTS_LIST.connect("change_animation",self,"on_animation_change")
	#connect("player_ready",DialogDisplay,"on_player_ready")
	#emit_signal("player_ready",self)
	
# TODO
# Para realizar acciones de movimiento sobre personajes cinematicos 
# Comprobar los DOCS
func _physics_process(delta) -> void:
	
	#var move = speed * delta

	#move_along_path(move)
	pass


func move_along_path(distance : float) -> void:
	
	var current_point = position

	#for i in range(path.size()):
	#	var distance_next = current_point.distance_to(path[0])

	#	if distance <= distance_next and distance > 0.0:
	#		position = current_point.linear_interpolate(path[0], distance / distance_next)
	#		break # TODO rework
		
	#	elif distance  < 0:
	#		position = path[0]
	#		break
	#	distance -= distance_next
	#	current_point = path[0]
	#	path.remove(0)

func on_player_pause() -> void:
	var state_machine = get_node("StateMachine")
	#state_machine.set_process(false)
	state_machine.set_process_input(false)

func on_player_resume() -> void:
	var state_machine = get_node("StateMachine")
	#state_machine.set_process(false)
	state_machine.set_process_input(true)

func set_path(value) -> void:
	#path = value
	print("DEBUG WORKS")
	#if path.size() != 0:
	#	set_physics_process(true)

func on_animation_change(new_animation : String, flip : bool) -> void:
	
	var animation : AnimatedSprite = get_node("AnimatedSprite")

	assert(animation != null)
	#print(new_animation)

	if !flip and animation.flip_h == true:
		animation.play(new_animation)
		#animation.flip_h = false
	elif flip:
		animation.flip_h = true
		animation.play(new_animation)

	#animation.play(new_animation)


func _unhandled_key_input(event):
	if event.is_action_pressed("save"):
		save_data()
		print("DEBUG --> Guardar")
		

# Funciones de guardado
# DEPRECATED
func save_this() -> Dictionary:

	var save_dictionary = {
		player_position = global_position
	}

	return save_dictionary




func save_data() -> void:

	var file_path = "res://player.save"
	
	var file = File.new()

	file.open(file_path,File.WRITE)
	
	##var player_position = global_position

	file.store_var(global_position)

	file.close()



func load_data() -> bool:
	
	var file_path = "res://player.save"
	
	var file = File.new()

	if file.file_exists(file_path):

		file.open(file_path,File.READ)
		global_position = file.get_var()
		file.close()
		return true
	 
	return false


func save(save_file : Resource) -> void:
	var save_dic : Dictionary

	save_dic['pos_x'] = self.global_position.x
	save_dic['pos_y'] = self.global_position.y

	# Store on save_file dictionary
	save_file.data[URI] = save_dic

func load(save_file : Resource) -> void:
	var save_dic : Dictionary = save_file.data[URI]

	# TODO look if this can be automated with a loop
	self.global_position.x = save_dic['pos_x']
	self.global_position.x = save_dic['pos_y']

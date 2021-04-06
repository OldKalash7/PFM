extends Actor

signal entered_level
signal player_ready(self_instance)

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


func set_path(value) -> void:
	#path = value
	print("DEBUG WORKS")
	#if path.size() != 0:
	#	set_physics_process(true)




func _unhandled_key_input(event):
	if event.is_action_pressed("save"):
		save_data()
		print("DEBUG --> Guardar")
		

# Funciones de guardado

func save() -> Dictionary:

	var save_dictionary = {
		player_position = global_position
	}

	return save_dictionary

func load() -> void:
	pass


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

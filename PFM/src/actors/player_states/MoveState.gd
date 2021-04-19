extends PlayerState


# Implementacion del estado de movimiento para el jugador

class_name MoveState

# Necesitaré la variable para aplicar la velocidad al jugador

func _ready():
	state_name = "MOVE_STATE"


func enter( args : Dictionary) -> void:
	#print("Entrado en MOVE STATE")
	# TODO rework con un animation player
	#var animation = get_parent()#.get_node("AnimatedSprite")

	pass

	#animation.play("side_walk")
	#print("MoveState debug -> se ha entrado en el moveState")

	

func exit() -> void:
	#print("MoveState debug -> se ha salido en el moveState")
	pass

func handle_input(event) -> void:
	pass

func handle_unhandled_input(event) -> void:        
	pass

func handle_unhandled_key_input(event) -> void:
	pass


	
func handle_process(delta) -> void:
	pass

func handle_physics_process(delta) -> void:
	_calculate_linear_velocity()
	player.move_and_collide(player.linear_velocity.normalized() * player.speed * delta)

func _calculate_linear_velocity() -> void:
	player.linear_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		Main.EVENTS_LIST.emit_signal("change_animation","up_walk",false)
		player.linear_velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		Main.EVENTS_LIST.emit_signal("change_animation","down_walk",false)
		player.linear_velocity.y += 1
	if Input.is_action_pressed("move_right"):
		Main.EVENTS_LIST.emit_signal("change_animation","side_walk",true)
		player.linear_velocity.x += 1
	if Input.is_action_pressed("move_left"):
		Main.EVENTS_LIST.emit_signal("change_animation","side_walk",false)
		player.linear_velocity.x -= 1
	if player.linear_velocity == Vector2.ZERO:
		get_parent().change_state_to("IDLE_STATE",{"transicion de estado": "test"})

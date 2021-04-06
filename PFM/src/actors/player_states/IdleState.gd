extends PlayerState


class_name IdleState




func enter( args : Dictionary) -> void:
	#player.linear_velocity = Vector2.ZERO This fails
	owner.linear_velocity = Vector2.ZERO
	print("Entrado en IDLE STATE")

func exit() -> void:
	pass


func handle_input(event) -> void:
	
	if event.is_action_pressed("move_up") || event.is_action_pressed("move_down") || event.is_action_pressed("move_left") || event.is_action_pressed("move_right"):
		get_parent().change_state_to("MOVE_STATE",{"transicion de estado": "test"})
		
		

func handle_unhandled_input(event) -> void:        
	pass

func handle_unhandled_key_input(event) -> void:
	pass


	
func handle_process(delta) -> void:
	pass

func handle_physics_process(delta) -> void:
	pass

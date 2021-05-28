extends PlayerState


class_name IdleState




func enter( args : Dictionary) -> void:
	#player.linear_velocity = Vector2.ZERO This fails
	owner.linear_velocity = Vector2.ZERO
	
	# Determinar que animación de idle hay que reproducir a partir de la última 
	# animación que el nodo ha reproducido
	if owner.get_node("AnimatedSprite").animation == "up_walk":
		Main.EVENTS_LIST.emit_signal("change_animation","up_idle",false)
	elif owner.get_node("AnimatedSprite").animation == "down_walk":
		Main.EVENTS_LIST.emit_signal("change_animation","down_idle",false)
	elif (owner.get_node("AnimatedSprite").animation == "side_walk") && !owner.get_node("AnimatedSprite").flip_h:
		Main.EVENTS_LIST.emit_signal("change_animation","side_idle",false)
	else:
		Main.EVENTS_LIST.emit_signal("change_animation","side_idle",true)

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

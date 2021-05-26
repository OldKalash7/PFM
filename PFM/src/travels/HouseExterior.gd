extends Travel


var dialog_actionable : Actionable


func _ready():
	dialog_actionable = get_node("DialogueActionable")
	set_process_input(false)

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
	else:
		dialog_actionable.action()
		

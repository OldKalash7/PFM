extends Item


func _ready():
	set_process_input(false)
	

func _on_player_interacts() -> void:
	set_process_input(true)


func _on_player_goes_away() -> void:
	set_process_input(false)
	

func _input(event):
	if Input.is_action_just_pressed("enter"):
		set_process_input(false)
		get_node("DialogueActionable").action()

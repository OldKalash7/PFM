extends Item

var actionable : Actionable

func _ready() -> void:
	actionable = get_node("DialogueActionable")
	set_process_input(false)

func _on_player_interacts() -> void:
	set_process_input(true)


func _on_player_goes_away() -> void:
	set_process_input(false)


func _input(event) -> void:
	if Input.is_action_pressed("enter"):
		actionable.action()

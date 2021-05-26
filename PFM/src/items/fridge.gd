extends Item


var dialog : Actionable

func _ready():
	dialog = get_node("DialogueActionable")

func _on_player_interacts() -> void:
	dialog.action()

func _on_player_goes_away() -> void:
	print("Override this function")

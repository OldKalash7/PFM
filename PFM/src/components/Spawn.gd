extends Position2D


class_name Position


export (String) var spawn_name : String



func _ready():
	pass
	

func spawn() -> void:
	# Get player in the current scene
	var player : Player = get_tree().get_current_scene().get_node("Player")
	
	# TODO mirar la dependencia de player
	assert (player != null)
	
	player.global_position = self.global_position
		

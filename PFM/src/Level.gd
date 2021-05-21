extends Node

# Clase base para todos los niveles que da soporte a la navegacion
# y otras funcionalidades


class_name Level

export (Vector2) var default_spawn_location : Vector2

var spawn_group : Node

func _ready():
	# Init
	Main.EVENTS_LIST.emit_signal("level_entered",self.filename.replace(self.filename.get_base_dir() + "/","").get_basename())
	spawn_group = get_node("Spawns")
	assert(spawn_group != null)
	initialize()

func _enter_tree():
	pass

# Initialize the level
func initialize() -> void:
	
	# Spawn the player at the desired location
	for spawn in get_node("Spawns").get_children():
		if spawn.spawn_name == Main.spawn_location:
			spawn.spawn()
	
	#get_tree().get_current_scene().get_node("TransitionLayer/Transition").play_in()

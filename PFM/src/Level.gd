extends Node

# Clase base para todos los niveles que da soporte a la navegacion
# y otras funcionalidades



class_name Level



func _ready():
	# Init
	Main.EVENTS_LIST.emit_signal("level_entered",self.filename.replace(self.filename.get_base_dir() + "/","").get_basename())



func initialize(player_instance : Player) -> void:
	self.add_child(player_instance)
	

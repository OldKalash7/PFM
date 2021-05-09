extends Area2D

# Este compomente permite trasladar al jugador y otros objetos a otros niveles.
# Gestiona la transición entre niveles

class_name Travel

var spawn_position : Position2D
export (bool) var enabled : bool
export (String) var where : String


func _ready():
	self.connect("body_entered",self,"_on_body_enters")


func travel_to() -> void:
	if enabled:
		pass

# Handles how the player spawns in the level after traveling
func spawn_player_in_level() -> void:
	pass


func _on_body_enters(body) -> void:
	# Filter player
	if body.name == "Player":
		travel_to()

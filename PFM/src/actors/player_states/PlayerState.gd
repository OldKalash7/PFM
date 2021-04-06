extends State


class_name PlayerState

var player : Player


func _ready():

	# Esperar a que el padre "Player" este listo
	yield(owner,"ready")

	# Asignación

	player = owner as Player
	# Comprobar que no es null en tiempo de compilacion
	
	assert (player != null)

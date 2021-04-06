extends Node2D

onready var _area : Area2D = $Area2D
func _ready():
	
	# Conectar la señal de Area2D
	_area.connect("body_entered",self,"on_player_interaction")
	

	# Conectar la señal con el Dialog Manager situado más arriba del árbol
	$Actionable.connect("start_dialog", DialogManager,"on_dialog_started")

func on_player_interaction(body) -> void:
	if body.name == "Player":
		print("DEBUG " + name + " --> " + body.name + " ha entrado en el area")
		$Actionable.emit_signal("start_dialog")


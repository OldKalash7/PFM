extends Node2D

onready var _area : Area2D = $Area2D

func _ready():
	
	
	# Conectar la señal de Area2D
	_area.connect("body_entered",self,"on_player_interaction")
	_area.connect("body_exited",self, "on_player_goes_away")
	

	# Conectar la señal con el Dialog Manager situado más arriba del árbol
	#$Actionable.connect("dialog_started", DialogManager,"on_dialog_started")

func on_player_interaction(body) -> void:

	if body.name == "Player":
		print("DEBUG " + name + " --> " + body.name + " ha entrado en el area")
		Main.EVENTS_LIST.emit_signal("dialog_started",$Actionable.dialog, $Actionable)
		

func on_player_goes_away(body) -> void:
	
	if body.name == "Player":
		#print("DEBUG " + name + " --> " + body.name + " ha salido del area")
		pass
		

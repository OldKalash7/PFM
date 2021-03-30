extends Node2D

var navegacion : Navigation2D
var linea : Line2D
var character : KinematicBody2D

func _ready():
	navegacion = $Navegacion
	linea = $Line2D
	character = $Player


func _unhandled_input(event) -> void:
	
	if not event is InputEventMouseButton:
		return 
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
		
	if Input.is_action_pressed("ui_right"):
		var new_path = navegacion.get_simple_path(character.global_position, (character.global_position.y * Vector2(0,30) ))
		
		
	var new_path = navegacion.get_simple_path(character.global_position, event.global_position)
	linea.points = new_path
	
	assert(character != null)
	
	character.set_path(new_path)
	

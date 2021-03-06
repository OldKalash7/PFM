extends Control

signal line_displayed

class_name DialogDisplay

var actor_line : RichTextLabel
var tween : Tween
var arrow : Sprite
var animation_player : AnimationPlayer


func _ready():
	tween = get_node("Tween")
	actor_line = get_node("ActorLine")
	arrow = get_node("Arrow")
	animation_player = get_node("AnimationPlayer")
	assert (tween != null)
	assert (actor_line != null)
	animation_player.play("bounce")
	#arrow.visible = false
	set_process_unhandled_key_input(false)


# Pinta la linea en pantalla
func display(line : String) -> void:
	actor_line.text = line
	_draw_text()
	# Espera a que termine de dibujarse el texto para dejar al jugador que avance el dialogo
	yield(tween,"tween_all_completed")
	# Arrow animation
	#arrow.visible = true
	animation_player.play("bounce")
	Main.EVENTS_LIST.emit_signal("line_displayed")



func _draw_text() -> void:
	# Animación de dibujado del texto	
	tween.interpolate_property(actor_line, "percent_visible", 0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	# Iniciar la animación
	tween.start()
	
	

# Cambia la visibilidad del display
func change_text_visibility(mode : bool) -> void:	
	pass


func hide_text() -> void:
	actor_line.percent_visible = 0;

# Procesa el input para el caso de las decisiones
func _unhandled_key_input(event) -> void:
	pass

extends DialogDisplay


var choices : ItemList 
var actor_name : RichTextLabel
var actor_line : RichTextLabel
var tween : Tween

func _ready():
	# Desconectar el unhandled input, solo lo activaremos
	# cuando haya decisiones que procesar
	set_process_unhandled_key_input(false)
	# Obtener la referencia de los componentes
	choices = $DialogLayer/Choices
	actor_name = $ActorName
	actor_line = $CharacterLine
	tween = $Tween

	# Poner el control ItemList Choices a invisible al principio
	choices.visible = false

	# Conectar las señales del ItemList de las decisiones
	choices.connect("nothing_selected",self,"on_nothing_selected")
	choices.connect("item_selected",self,"on_decision_selected")
	choices.connect("item_activated",self,"on_decisions_activated")

	# Conectar con parent las señales de line_displayed
	#self.connect("line_displayed",get_parent(),"on_line_displayed")

func display(character_name : String, line : String) -> void:
	# Reiniciar la propiedad de visibilidad del label para que no se vea la anterior linea cuando empieze el dialogo
	actor_line.percent_visible = 0
	actor_line.text = line
	change_display_visibility(true)
	
	# Animación de dibujado del texto	
	tween.interpolate_property($CharacterLine, "percent_visible", 0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	# Iniciar la animación
	tween.start()
	# Esperar a que termine para emitir la señal de linea mostrada
	yield(tween,"tween_all_completed")
	emit_signal("line_displayed")



func change_display_visibility(mode : bool) -> void:
	actor_name.visible = mode
	actor_line.visible = mode
	

func draw_text(tween_node : Tween, label : RichTextLabel, line : String) -> void:
	label.percent_visible = 0
	label.text = line
	
	# Animación de dibujado del texto	
	tween_node.interpolate_property(label, "percent_visible", 0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	# Iniciar la animación
	tween_node.start()
	yield(tween,"tween_all_completed")

	




func display_choices(choices_list : Array) -> void:
	
	# Hacer visible Choices
	choices.visible = true
	# Hacer focus en el control ItemList
	choices.grab_focus()
	# Selecciona el primer item por defecto
	choices.select(0,true)



func on_nothing_selected() -> void:
	pass

func on_decision_selected(_index) -> void:
	pass

func on_decsision_activated(index) -> void:
	emit_signal("choice_selected",index)

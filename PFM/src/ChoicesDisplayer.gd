extends Control

class_name ChoicesDisplayer

# Referencia al itemlist en donde se mostraran las diferentes opciones
var _choices_display : ItemList


func _ready():
	
	_choices_display = get_node("ChoicesLayer/Choices")
	assert(_choices_display != null)
	# Conectar señales del nodo ItemList para cuando el jugador elija alguna de las opciones
	_choices_display.connect("item_activated",self,"_on_choice_selected")
	change_choices_display_visibility(false)


func _on_choice_selected(index : int) -> void:
	Main.EVENTS_LIST.emit_signal("choice_selected",index)
	# Ocultar las decisiones
	change_choices_display_visibility(false)
	# Vaciar el contenido del ItemList
	_choices_display.clear()


func change_choices_display_visibility(display : bool) -> void:
	_choices_display.visible = display


func display_choiches(values : Dictionary) -> void:
	
	# Focus en el control de la UI
	_choices_display.grab_focus()
	
	#var values : Dictionary = choices_entrie.get("decisiones")
	var choice_contents : Array

	for i in values:
		choice_contents = values.get(String(i))
		_choices_display.add_item(choice_contents[0])


	# Selecciona el primer item por defecto
	_choices_display.select(0,true)

	# Mostrar en pantalla
	change_choices_display_visibility(true)
	

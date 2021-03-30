# DialogDisplay se encarga únicamente de mostrar por pantalla la parte gráfica de los dialogos
# El diseño está pensado para que no ejecute ninguna parte de lógica, tan solo recibirá líneas y las mostrará

extends Control

signal dialog_completed

signal milestone_reached

class_name DialogDisplay

enum DIALOG_STATE {FINISHED,DISPLAYING,DEFAULT}
var milestones = preload("res://resources/Milestones.gd")
# Nombre que aparecerá en el 
var _character_name : RichTextLabel
# Linea de dialogo
var _dialog_line : String

var _vbox_decisiones : VBoxContainer

var modo_decisiones : bool = false

onready var _dialog_pointer : int = 0

onready var _test_dialog : Dictionary = {

	0: {	
			"nombre":"prueba",
			"line"	:"Bloque numero uno",
			"decisiones":{},
			"pointer": 1
		} ,

	1: {	
			"nombre":"segundo",
			
			"line"	:"Bloque numero dos",
			
			"decisiones": {

				0:["Esta es la primera decision","",0],
				1:["Esta es la segunda decision","callback_test",1,[]],
				2:["Esta es la tercera decision","",2]
			},
			"pointer": 2
		} ,

	2: {	
			"nombre":"otra persona",
			"line"	:"Bloque numero tres",
			"decisiones": {},
			"pointer": -1
		} 
	#0 : ["test","frase del dialogo", {}, "funcion",1],
	#1 : ["otro", "otra frase", {}, "funcion",-1]

}

var _dialog : Dictionary


func _ready():
	# Conectar señales con un nodo de Dialog Manager TODO Explicar documentacion
	connect("dialog_completed",get_parent(),"on_dialog_completed")
	connect("milestone_reached",get_parent(),"on_milestone_reached")

	_character_name = $CharacterName
	_vbox_decisiones = $Control/VBoxDecisiones
	#set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	load_dialog()
	


func load_dialog() -> void:
	# Texto dialogo
		##$RichTextLabel.bbcode_text = dialog.get(dialog_keys[key_pointer]).get("text")
		# Nombre del personaje
		##$CharacterName.bbcode_text = dialog.get(dialog_keys[key_pointer]).get("name")
		# Animacion de escribir el texto
		$CharacterName.text = _test_dialog.get(_dialog_pointer).get("nombre")
		$CharacterLine.percent_visible = 0
		$CharacterLine.text = _test_dialog.get(_dialog_pointer).get("line")
		$Tween.interpolate_property($CharacterLine, "percent_visible", 0, 1, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()

		yield($Tween,"tween_all_completed")


		var decisiones : Dictionary = _test_dialog.get(_dialog_pointer).get("decisiones")

		# Si tiene decisiones este dialogo
		if decisiones.empty():
			print("NO HAY DECISIONES PARA ESTA ENTRADA")
			modo_decisiones = false
		else:
			print("DECISIONES")
			modo_decisiones = true

		var contador : int = 0

		for i in decisiones.size():
			contador += 1
			
			#var button : Button = Button.new()
			var text = str(contador ) + ". " + decisiones[i][0]
			$Control/ItemList.add_item(text)

			if contador == 1:
				$Control/ItemList.select(0,true)

			#button.text = str(contador ) + ". " + decisiones[i][0]
			#button.align = 0
			#_vbox_decisiones.add_child(button)
			print(decisiones[i][0])

				
				
		set_process_unhandled_key_input(true)

		

		
			
			

		#_unhandled_key

func _unhandled_key_input(event):
	
	# Si unhandled input esta activo, registrará cuando el jugador pulsa enter para cargar la siguiente linea
	
	# TODO simplificar la estructura condicional

	if event.is_action_pressed("enter") && modo_decisiones:
		
		print($Control/ItemList.get_selected_items()[0])
		print(_test_dialog.get(_dialog_pointer).get("decisiones").get($Control/ItemList.get_selected_items()[0])[2])
		
		#.get($Control/ItemList.get_selected_items()).get(2)
		# TODO Sacar a funcion
		_dialog_pointer = _test_dialog.get(_dialog_pointer).get("decisiones").get($Control/ItemList.get_selected_items()[0])[2]

		# Comprobar si tiene decisiones
		if _test_dialog.get(_dialog_pointer).get("decisiones").get($Control/ItemList.get_selected_items()[0])[1]:
			
			var f = funcref(self, "callback_test")
			f.call_func()

		$Control/ItemList.clear()
		load_dialog()

		set_process_unhandled_key_input(false)

	elif event.is_action_pressed("enter"):
		print("Es una linea sin decision y se ejecuta el elif")
		_dialog_pointer = _test_dialog.get(_dialog_pointer).get("pointer")
		# Avanzar el dialogo a la siguiente linea
		if _dialog_pointer == -1:
			emit_signal("dialog_completed")
			#yield(self,"dialog_completed")
			#set_process_unhandled_key_input(false)
			#visible = 0
		else:
			load_dialog()
	
	
		set_process_unhandled_key_input(false)

		
	
func callback_test() -> void:
	print("Callback")


func update_dialog(new_line : String) -> void:
	pass

func update_name(new_name : String) -> void:
	pass



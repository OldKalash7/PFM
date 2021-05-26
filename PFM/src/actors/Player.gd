extends Actor

signal entered_level
signal player_ready(self_instance)


class_name Player

onready var animation : AnimatedSprite = get_node("AnimatedSprite")
export (String) var URI = "current_player_instance_" + name
var linear_velocity : Vector2


func _ready():
	#$StateMachine._state = $StateMachine/IdleState
	Main.EVENTS_LIST.connect("player_pause",self,"on_player_pause")
	Main.EVENTS_LIST.connect("player_resume",self,"on_player_resume")
	Main.EVENTS_LIST.connect("change_animation",self,"on_animation_change")
	#connect("player_ready",DialogDisplay,"on_player_ready")
	#emit_signal("player_ready",self)
	

func _physics_process(delta) -> void:
	pass


func on_player_pause() -> void:
	var state_machine = get_node("StateMachine")
	#state_machine.set_process(false)
	state_machine.set_process_input(false)
	state_machine.set_physics_process(false)
	
	match animation.animation:
		"up_walk":
			animation.play("up_idle")
		"down_walk":
			animation.play("down_idle")
		"side_walk":
			animation.play("side_idle")


func on_player_resume() -> void:
	var state_machine = get_node("StateMachine")
	#state_machine.set_process(false)
	state_machine.set_process_input(true)
	state_machine.set_physics_process(true)


func on_animation_change(new_animation : String, flip : bool) -> void:
	
	assert(animation != null)
	
	animation.flip_h = flip
		
	animation.play(new_animation)


func _unhandled_key_input(event):
	pass
		

# Funciones de guardado
func save(save_file : Resource) -> void:
	var save_dic : Dictionary

	save_dic['position'] = global_position


	# Store on save_file dictionary
	save_file.store_data(URI,save_dic)
	



func load(save_file : Resource) -> void:
	var save_dic : Dictionary = save_file.retrieve_data(URI)

	if !save_dic.empty():
		# TODO look if this can be automated with a loop
		global_position = save_dic['position']

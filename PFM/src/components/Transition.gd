extends Control


signal transintion_finished


# Base class that controls different visual transition effects between levels and cutscenes
class_name Transition


export(String, "CutoffTransition", "Test") var transition_type : String

var transition_node : TransitionEffect

func _ready():
	transition_node = get_node(transition_type)
	#
	#transition_node.play_out()
	

func play_in() -> void:
	transition_node.play_in()


func play_stop() -> void:
	transition_node.play_stop()


func _on_animation_finished(anim_name : String) -> void:
	emit_signal("transintion_finished")

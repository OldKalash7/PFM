extends ColorRect


signal finished


class_name TransitionEffect


var animation_player : AnimationPlayer


func _ready():
	animation_player = get_node("AnimationPlayer")

	animation_player.connect("animation_finished",get_parent(),"_on_animation_finished")


func play_in() -> void:
	if animation_player.is_playing():
		yield(animation_player,"animation_finished")
	animation_player.play("fade_in")

func play_out() -> void:
	if animation_player.is_playing():
		yield(animation_player,"animation_finished")
	animation_player.play("fade_out")


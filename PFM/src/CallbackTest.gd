extends Sprite


func _ready():
	Main.EVENTS_GAME.connect("vanish_test",self,"on_vanish")


func on_vanish() -> void:
	queue_free()

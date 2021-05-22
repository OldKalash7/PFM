extends Area2D


# Base class for items in the game
class_name Item


func _ready():
	self.connect("body_entered",self,"_on_body_enters")
	self.connect("body_exited",self,"_on_body_exits")


func _on_player_interacts() -> void:
	print("Override this function")

func _on_player_goes_away() -> void:
	print("Override this function")


func _on_body_enters(body) -> void:
	if body.name == "Player":
		_on_player_interacts()
		


func _on_body_exits(body)-> void:
	if body.name == "Player":
		_on_player_goes_away()


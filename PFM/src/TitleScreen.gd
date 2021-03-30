extends Control


func _ready():
	$PopupDialog.popup()

func _on_Exit():
	Main.exit()

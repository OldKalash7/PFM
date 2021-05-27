extends Actionable


class_name QuestActionable


export(String, FILE, "*.json") var quest_path : String
var game_state : Node


func _ready():
	# Retrieve GameState from the tree
	game_state = get_tree().get_root().get_node("GameStateManager")
	


func action() -> void:
	if quest_path != null && !quest_path.empty():
		var quest : Quest = Main.QUEST_FACTORY.make_quest(quest_path)
		quest.connect("quest_created",game_state,"_on_new_quest",[],CONNECT_ONESHOT)
		quest.emit_signal("quest_created",quest)

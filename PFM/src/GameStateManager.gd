extends StateMachine


# Controla y gestiona el estado del juego y su avance


var quests : Array
var states : Node


func _ready():
	states = get_node("States")
	
	
#func change_state_to(state_to_enter) -> void:
	# Exit old state
	# Enter new state
#	pass


func change_state_to(new_state_name : String, args : Dictionary) -> void:

	# Conseguir el nuevo estado
	var new_state = get_node("States/" + new_state_name)
	# Salir del estado anterior
	# Este check es necesario porque la primera vez el state es null
	if _state != null:
		_state.exit()
	# Cambiar el estado y llamar a la función de entrar
	_state = new_state
	_state.enter(args)
	# Emitir señal diciendo que ha entrado en el nuevo estado
	emit_signal("changed_to_new_state",_state.name)

# Similar to process or update 
func update() -> void:
	_state.update()


func _on_new_quest(quest : Quest) -> void:
	quest.quest_status = Quest.STATUS.ASSIGNED
	quests.push_front(quest)
	
	
func quest_exists(quest_uri : String) -> bool:
	for quest in quests:
		if quest.quest_uri == quest_uri:
			return true
	return false
	

func get_quest_by_name(quest_uri : String) -> Quest:
	var quest : Quest = Quest.new("","","")
	
	for i in quests:
		if i.quest_uri == quest_uri:
			quest = i
			return quest
			
	return quest

func change_quest_status(quest_uri: String, new_status : int) -> void:
	if quest_exists(quest_uri):
		var quest : Quest = get_quest_by_name(quest_uri)
		quest.quest_status = new_status
		quest.emit_signal("quest_updated",quest.quest_uri, quest.quest_status)
	
	
func is_quest_active(quest_name : String) -> bool:
	for quest in quests:
		if quest.quest_uri == quest_name && quest.quest_status == Quest.STATUS.ASSIGNED:
			return true
	return false
	
func get_current_quest_info() -> Dictionary:
	var quest_info : Dictionary
	
	for quest in quests:
		if quest.quest_status == Quest.STATUS.ASSIGNED:
			quest_info[quest.quest_uri] = [quest.quest_objective,quest.quest_description]
			
	return quest_info


# SAVE / LOAD FUNCTIONS
	
func save(save_game : Resource) -> void:
	var save_dic : Dictionary
	var quests_to_save : Array
	
	save_dic['current_state'] = _state.name
	
	for i in quests:
		quests_to_save.append(
			{'quest_uri': i.quest_uri, 'quest_objective' : i.quest_objective, 'quest_status' : i.quest_status, 'quest_description' :i.quest_description}
			
			) 
		
	save_dic['quests'] = quests_to_save
	
	save_game.store_game_state(save_dic)

func load_state(save_game : SaveFile) -> void:
	var save_dic : Dictionary = save_game.retrieve_game_state()
	var quests_to_load : Array
	
	_state = states.get_node(save_dic['current_state'])
	quests_to_load  = save_dic['quests']
	
	# Retrieve quest information
	
	for i in quests_to_load:
		var quest = Quest.new(i['quest_uri'],i['quest_objective'], i['quest_description'])
		quest.set_quest_status(i['quest_status'])
		quests.append(quest)
	

func save_pool_changes(save_name : String) -> void:
	get_node("States/GameChangesPool").save_changes(save_name)
	
	
func load_pool_changes(save_name : String) -> void:
	get_node("States/GameChangesPool").load_changes(save_name)

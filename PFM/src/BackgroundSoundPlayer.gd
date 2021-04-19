extends Node

# Clase Singleton con acceso global para reproducir audio en background
# de manera que no se interrumpa entre transición de niveles

var _current_audio_player : AudioStreamPlayer
export var default_audio_player : String

var _audio_timer : Timer


func _ready():
	# TODO Inicializar buses de audio y demas temas relacionados aqui 
	# TODO Investigar los problemas del timer via código en la documentación de godot
	# Recordar el problema que hubo durante el desarrollo de Codename Z


	_current_audio_player = get_node(default_audio_player)

	assert (_current_audio_player != null)

	_audio_timer = $Timer
	
	# Conectar la señal del timeout
	
	#$Timer.connect("timeout",self,"on_audio_timer_timeout")
	
	# LOOP AUDIO
	#_current_audio_player.set_loop(true)
	#_current_audio_player.stream.set_loop(true)
	#_current_audio_player.play()

func play_audio(audio_player_name : String, loop : bool) -> void:
	
	var audio_player : AudioStreamPlayer = get_node(audio_player_name)

	if audio_player != null:

		if _current_audio_player.is_playing():
			stop_audio()
			_current_audio_player = audio_player

		if loop:
			_current_audio_player.play()
		else:
			pass
	else:
		print("DEBUG --> Error with " + self.name + " al intentar reproducir " 
		+ audio_player_name + " no existe ese nodo o el nombre esta mal" )
	
	
func stop_audio() -> void:
	_current_audio_player.stop()

	
func on_audio_timer_timeout() -> void:
	_audio_timer.stop()

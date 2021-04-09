extends Node

# Clase Singleton con acceso global para reproducir audio en background
# de manera que no se interrumpa entre transición de niveles

var _player : AudioStreamPlayer
var _audio_timer : Timer
func _ready():
	# TODO Inicializar buses de audio y demas temas relacionados aqui 
	# TODO Investigar los problemas del timer via código en la documentación de godot
	# Recordar el problema que hubo durante el desarrollo de Codename Z
	_player = AudioStreamPlayer.new()
	_audio_timer = Timer.new()
	
	# Conectar la señal del timeout
	
	_audio_timer.connect("timeout",self,"on_audio_timer_timeout")

func play_audio(audio_file_name : String, time : int) -> void:
	# Recuperar el recurso de sonido a partir del nombre del fichero
	
	# Determinar el tiempo que se va a reproducir
	
	if time > 0:
		pass
	
func stop_audio() -> void:
	pass
	
func pause_audio() -> void:
	pass
	
func on_audio_timer_timeout() -> void:
	_audio_timer.stop()

extends Node

# Clase base para la declaración y conexión de diferentes tipos de señales


class_name Events

# Aqui hariamos un preload o load de un script que solo contenga declaraciones de Señales ya que no se pueden declarar en runtime
signal event_signal(msg)


# Señales
signal dialog_started(dialog, actioanable)
signal player_pause # Pausa al proceso del input del jugador
signal player_resume # Reanudar proceso del input del jugador
signal change_animation(new_animation,flip)

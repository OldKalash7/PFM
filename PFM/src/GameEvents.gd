extends Node

# Singleton para controlar los callbacks que afectan al estado del juego

# Derivado de Events que se utiliza para lanzar las callbacks de los dialogos o cualquier otra callback que haga avanzar o cambiar el estado del juego

class_name GameEvents


signal vanish_test
signal change_to_find_key
signal change_to_exit_house
signal trigger_leave_cutscene
signal found_code
signal key_taken
signal key_found





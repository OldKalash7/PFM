extends Node

const save_path : String = "res://savegame.dat"



func exit() -> void:
    get_tree().quit()

func save_game() -> void:
    
    # Recuperar todos los nodos que esten en el grupo de persistencia

    var nodes = get_tree().get_nodes_in_group("persistencia")

    # Abrir el archivo
    var file = File.new()
    file.open(save_path,File.WRITE)

    # Iterar por los nodos y llamar a su método de guardado
    for node in nodes:
        if node.has_method("save"):
            var save_dictionary = node.save()



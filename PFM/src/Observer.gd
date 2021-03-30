extends Node2D

class_name Observer


# preload a diferencia de load carga el recurso en tiempo de compilacion

# Cargar el enum de eventos
var milestones = preload("res://resources/Milestones.gd")

func onNotify(entity : Node, milestone) -> void:
    print("If you are seeing this on the output, "+
    "override this function")
    pass
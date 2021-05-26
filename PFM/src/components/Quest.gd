extends Node2D


class_name Quest

enum STATUS {CREATED = 0, ASSIGNED = 1, HOLD = 2, COMPLETED = 3, FAILED = 4}

var quest_uri : String
var quest_objective : String
var quest_status : int
var quest_description : String

func _ready():
	quest_status = STATUS.CREATED






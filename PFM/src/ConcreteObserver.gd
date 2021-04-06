extends Observer

class_name ConcreteObserver


func onNotify(entity : Node, milestone) -> void:

    match typeof(milestone):
        milestones.TEST:
            print("MIlestone Test alcanzada")

    
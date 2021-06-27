extends Node2D
class_name Level


func _ready() -> void:
	for node in get_children():
		if node is Classes.SOLDIER:
			node.set_level(self)
		if node is Classes.BLACKBOARD:
			node.init_blackboard()

extends "res://scenes/ais/base/BaseAI.gd"


func _ready() -> void:
	blackboard["enemy_pos"] = null


#param 0: shared blackboard name
func task_player_spotted(task):
	if blackboard["enemy_pos"] != null:
		task.succeed()
	else:
		set_blackboard("enemy_pos", null, task.get_param(0))
		task.failed()


#param 0: shared blackboard name
func task_set_blackboard_player_pos(task):
	set_blackboard("enemy_pos", blackboard["enemy_pos"], task.get_param(0))
	task.succeed()

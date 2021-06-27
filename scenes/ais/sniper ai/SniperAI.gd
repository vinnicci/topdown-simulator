extends "res://scenes/ais/base/BaseAI.gd"


#param 0: shared blackboard name
func task_enemy_pos_valid(task):
	if get_blackboard("enemy_pos", task.get_param(0)) != null:
		task.succeed()
	else:
		task.failed()


#param 0: shared blackboard name
func task_aim_spotter_report(task):
	weapon.look_at(get_blackboard("enemy_pos", task.get_param(0)))
	task.succeed()

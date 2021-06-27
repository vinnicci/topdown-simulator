extends Weapon


var enemy
var parent_ai


func _process(_delta: float) -> void:
	if is_instance_valid(enemy) == true:
		if is_instance_valid(parent_ai) == false:
			parent_ai = parent_node.get_node("AI")
		#report enemy position
		parent_ai.blackboard["enemy_pos"] = enemy.global_position


func _on_Area2D_body_entered(body):
	if body is Player:
		enemy = body


func _on_Area2D_body_exited(body):
	if body == enemy:
		enemy = null
		parent_ai.blackboard["enemy_pos"] = null

extends Node2D


var enemy: Soldier = null
var parent_node: Soldier = null
var weapon: Weapon = null


func set_parent(new_parent: Soldier) -> void:
	parent_node = new_parent
	weapon = parent_node.get_node("Weapon")


func _physics_process(delta: float) -> void:
	if enemy != null:
		$Target.look_at(enemy.global_position)


func _on_DetectionRange_body_entered(body: Node) -> void:
	if body is Player:
		enemy = body


#btree tasks


func task_is_enemy_found(task):
	if enemy == null:
		parent_node.velocity = Vector2(0,0)
		task.failed()
	else:
		task.succeed()
	return


func task_is_enemy_close(task):
	if global_position.distance_to(enemy.global_position) <= task.get_param(0):
		task.succeed()
	else:
		task.failed()
	return


func task_seek_enemy(task):
	$Velocity.global_rotation = $Target.global_rotation
	parent_node.velocity = Vector2(1,0).rotated($Velocity.global_rotation)
	task.succeed()
	return


func task_is_out_of_ammo(task):
	if weapon.current_ammo_count == 0:
		task.succeed()
	else:
		task.failed()
	return


func task_shoot_enemy(task):
	weapon.global_rotation = $Target.global_rotation
	parent_node.fire_weapon()
	task.succeed()
	return


func task_reload(task):
	parent_node.reload_weapon()
	task.succeed()
	return


func task_back_off(task):
	$Velocity.global_rotation = $Target.global_rotation - deg2rad(180)
	parent_node.velocity = Vector2(1,0).rotated($Velocity.global_rotation)
	task.succeed()
	return

extends Node2D


var parent_node: Soldier = null
var weapon: Weapon = null
var blackboard: Dictionary
var is_moving: bool = false


func set_parent(new_parent: Soldier) -> void:
	parent_node = new_parent
	weapon = parent_node.get_node("Weapon")
	blackboard["weapon_range_on_seek"] = weapon.weap_range - 300
	blackboard["weapon_range"] = weapon.weap_range


func _ready() -> void:
	blackboard["enemy"] = null


func _physics_process(delta: float) -> void:
	if is_moving == true:
		go_to_target()
	else:
		parent_node.velocity = Vector2.ZERO


func go_to_target():
	parent_node.velocity = (blackboard["target"] - global_position).normalized()


func _on_DetectionRange_body_entered(body: Node) -> void:
	if body is Player && is_instance_valid(blackboard["enemy"]) == false:
		blackboard["enemy"] = body


#btree tasks


#param 0: target key/name in blackboard
func task_is_target_valid(task):
	if is_instance_valid(blackboard[task.get_param(0)]) == true:
		task.succeed()
	else:
		task.failed()


func task_is_out_of_ammo(task):
	if weapon.current_ammo_count == 0:
		task.succeed()
	else:
		task.failed()


#param 0: target key/name in blackboard
#param 1: distance needed also in blackboard
func task_is_target_close(task):
	if (global_position.distance_to(blackboard[task.get_param(0)].global_position)
	<= blackboard[task.get_param(1)]):
		task.succeed()
	else:
		task.failed()


#param 0: target
func task_aim_weapon(task):
	weapon.look_at(blackboard[task.get_param(0)].global_position)
	task.succeed()


func task_shoot_weapon(task):
	parent_node.fire_weapon()
	task.succeed()


func task_reload_weapon(task):
	parent_node.reload_weapon()
	task.succeed()


#param 0: backoff or seek
func task_get_target_point(task):
	if task.get_param(0) == "backoff":
		back_off_target_point()
	elif task.get_param(0) == "seek":
		seek_target_point()
	task.succeed()


func back_off_target_point():
	blackboard["target"] = -(blackboard["enemy"].global_position -
	global_position).clamped(1) * 1000


func seek_target_point():
	blackboard["target"] = blackboard["enemy"].global_position


const MIN_TARGET_DIST: int = 50
const ORIGIN_ENEMY_DIST: int = 50


#param 0: backoff or seek
#param 1: target to track -> enemy, ally, patrol point etc.
func task_go_to_target_point(task):
	is_moving = true
	if task.get_param(0) == "backoff":
		if (blackboard[task.get_param(1)].global_position.distance_to(blackboard["target"])
		> ORIGIN_ENEMY_DIST):
			back_off_target_point()
		if (global_position.distance_to(blackboard[task.get_param(1)].global_position) > 
		blackboard["weapon_range"] || weapon.current_ammo_count != 0):
			is_moving = false
			task.succeed()
		#else task will keep running
	elif task.get_param(0) == "seek":
		if (blackboard[task.get_param(1)].global_position.distance_to(blackboard["target"])
		> ORIGIN_ENEMY_DIST):
			seek_target_point()
		if (global_position.distance_to(blackboard[task.get_param(1)].global_position) <=
		blackboard["weapon_range_on_seek"]):
			is_moving = false
			task.succeed()
		#else task will keep running









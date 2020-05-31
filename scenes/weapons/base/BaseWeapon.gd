extends Node2D
class_name Weapon


export(int) var weap_range: = 200
export(int) var max_ammo_count: = 30
export(float) var fire_cooldown: = 0.5
export(float) var reload_cooldown: = 1
export(String) var action_quote: = ""
export(String) var damage_quote: = ""
var current_ammo_count
var parent_node: Soldier


#initialize weapon
func _ready() -> void:
	$FireCooldown.wait_time = fire_cooldown
	$ReloadCooldown.wait_time = reload_cooldown
	current_ammo_count = max_ammo_count
	$RayCast2D.cast_to = Vector2(weap_range, 0)


func set_parent(new_parent: Soldier) -> void:
	parent_node = new_parent
	$RayCast2D.add_exception(parent_node)


func fire() -> void:
	if $ReloadCooldown.is_stopped() == false || $FireCooldown.is_stopped() == false || current_ammo_count == 0:
		return
	$MuzzleFlash/Anim.play("flash")
	var body = $RayCast2D.get_collider()
	if body is Soldier:
		body.take_damage(damage_quote)
	current_ammo_count -= 1
	$FireCooldown.start()
	if current_ammo_count == 0:
		parent_node.set_status("out of ammo!")
		$HideStatusTimer.stop()
		return
	parent_node.set_status(action_quote + "\nammo count: " + current_ammo_count as String)
	$HideStatusTimer.start()


func reload() -> void:
	if $ReloadCooldown.is_stopped() == false || current_ammo_count == max_ammo_count:
		return
	parent_node.set_status("reloading!")
	$HideStatusTimer.stop()
	$ReloadCooldown.start()


func _on_ReloadCooldown_timeout() -> void:
	current_ammo_count = max_ammo_count
	parent_node.set_status("")


func _on_HideStatusTimer_timeout() -> void:
	parent_node.set_status("")

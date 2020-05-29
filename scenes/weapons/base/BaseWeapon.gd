extends Node2D
class_name Weapon


export(int) var weap_range: = 200
export(int) var max_ammo_count: = 30
export(float) var fire_cooldown: = 0.5
export(float) var reload_cooldown: = 1
export(String) var action_quote: = ""
export(String) var damage_quote: = ""
var current_ammo_count
onready var parent_node: = get_parent()


#initialize weapon
func _ready() -> void:
	$FireCooldown.wait_time = fire_cooldown
	$ReloadCooldown.wait_time = reload_cooldown
	current_ammo_count = max_ammo_count
	$AmmoCount.text = current_ammo_count as String
	$RayCast2D.cast_to = Vector2(weap_range, 0)
	$RayCast2D.add_exception(parent_node)
	$Line2D.add_point(Vector2(0,0))
	$Line2D.add_point($RayCast2D.cast_to)


func fire() -> void:
	if $FireCooldown.is_stopped() == false || current_ammo_count == 0:
		return
	parent_node.set_status(action_quote)
	$Line2D/Anim.play("fade")
	var body = $RayCast2D.get_collider()
	if body is Soldier:
		body.take_damage(damage_quote)
	current_ammo_count -= 1
	if current_ammo_count == 0:
		parent_node.set_status("out of ammo!")
	$AmmoCount.text = current_ammo_count as String
	$FireCooldown.start()


func reload() -> void:
	if $ReloadCooldown.is_stopped() == false || current_ammo_count == max_ammo_count || $FireCooldown.is_stopped() == false:
		return
	parent_node.set_status("reloading!")
	$ReloadCooldown.start()


func _on_ReloadCooldown_timeout() -> void:
	current_ammo_count = max_ammo_count
	$AmmoCount.text = current_ammo_count as String
	parent_node.set_status("")

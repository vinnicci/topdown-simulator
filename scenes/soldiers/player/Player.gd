extends "res://scenes/soldiers/base/BaseSoldier.gd"


func control(delta) -> void:
	$Weapon.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("up"):
		velocity += Vector2(0, -1)
	elif Input.is_action_pressed("down"):
		velocity += Vector2(0, 1)
	if Input.is_action_pressed("left"):
		velocity += Vector2(-1, 0)
	elif Input.is_action_pressed("right"):
		velocity += Vector2(1, 0)
	
	if Input.is_action_pressed("fire"):
		fire_weapon()
	if Input.is_action_just_pressed("reload"):
		reload_weapon()

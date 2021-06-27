extends Soldier
class_name Player


func _physics_process(_delta: float) -> void:
	$Weapon.look_at(get_global_mouse_position())
	
	#movement
	if Input.is_action_pressed("up"):
		velocity += Vector2(0, -1)
	elif Input.is_action_pressed("down"):
		velocity += Vector2(0, 1)
	if Input.is_action_pressed("left"):
		velocity += Vector2(-1, 0)
	elif Input.is_action_pressed("right"):
		velocity += Vector2(1, 0)
	
	#fire weapon
	if Input.is_action_pressed("fire"):
		fire_weapon()
	
	#reload weapon
	if Input.is_action_just_pressed("reload"):
		reload_weapon()

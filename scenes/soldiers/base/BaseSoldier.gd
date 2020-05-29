extends RigidBody2D
class_name Soldier


#don't forget to give soldier a weapon


export(int) var speed: = 100
var velocity: Vector2


#these functions handles rigid body movement
#might be different if you're using kinematic bodies
func _physics_process(delta: float) -> void:
	control(delta)


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if velocity.is_normalized() == false:
		velocity = velocity.normalized()
	velocity = velocity * speed
	applied_force = velocity
	velocity = Vector2(0,0)


func set_status(text: String) -> void:
	$Status.text = text


#ai will access these functions below

#movement
#virtual func accessible by player or ai
func control(delta) -> void:
	pass


#fire weapon
#be sure to attach weapon
func fire_weapon() -> void:
	$Weapon.fire()


#reloading
func reload_weapon() -> void:
	$Weapon.reload()


#damage simulation
#soldier won't die
#you can implement death mechanic yourself,
#but for now you will only see which weapon hit
func take_damage(text: String) -> void:
	$DamageStatus.text = text

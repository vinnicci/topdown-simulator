extends RigidBody2D
class_name Soldier


#don't forget to give soldier a weapon
export(int) var speed: = 1000
var velocity: Vector2


func _ready() -> void:
	#weapon component
	$Weapon.set_parent(self)
	
	#npc ai component
	if has_node("AI"):
		$AI.set_parent(self)


func set_status(text: String) -> void:
	$Status.text = text


#movement
#these function handles rigid body movement
#might be different if you're using kinematic bodies
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	velocity = velocity.normalized()
	velocity *= speed
	applied_force = velocity
	velocity = Vector2(0,0)


#fire weapon
func fire_weapon() -> void:
	$Weapon.fire()


#reload weapon
func reload_weapon() -> void:
	$Weapon.reload()


#damage simulation
#for now you will only see which weapon hit
func take_damage(text: String) -> void:
	$DamageStatus.text = text
	$HideDamageStatusTimer.start()


func _on_HideDamageStatusTimer_timeout() -> void:
	$DamageStatus.text = ""

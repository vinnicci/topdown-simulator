extends Node2D


export var speed = 5
var _range
var _damage_quote: String
var velocity: Vector2


func _on_BaseProjectile_body_entered(body):
    body.take_damage(_damage_quote)
    queue_free()


func _physics_process(_delta: float) -> void:
    if(_range <= 0):
        queue_free()
        return
    _range -= speed
    position += velocity


func spawn(lvl_node, p_range, damage_quote, global_pos, global_rot):
    _range = p_range
    _damage_quote = damage_quote
    velocity = Vector2(speed, 0).rotated(global_rot)
    global_position = global_pos
    global_rotation = global_rot
    lvl_node.add_child(self)

extends Weapon


export var projectile: PackedScene
onready var muzzle = $MuzzleFlash


func fire():
    if .fire() == false:
        return
    var proj = projectile.instance()
    proj.spawn(parent_node.level_node, weap_range, damage_quote, muzzle.global_position, global_rotation)
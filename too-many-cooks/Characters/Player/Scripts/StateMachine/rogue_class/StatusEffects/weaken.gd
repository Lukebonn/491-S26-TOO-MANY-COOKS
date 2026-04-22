extends Node

var target

var potency : float = 0.8

var duration : float = 10.0

##saves target's orignal damage then reduces current damage by potency
#after duration passes, restores damage to its original value
func _ready() -> void:
	var old_damage = target.damage
	target.damage *= potency
	
	await get_tree().create_timer(duration).timeout
	
	target.damage = old_damage
	queue_free()

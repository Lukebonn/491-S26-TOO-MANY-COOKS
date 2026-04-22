extends Node

var target

var potency : float = 0.6

var duration : float = 10.0

##saves target's orignal speed then reduces current speed by potency
#after duration passes, restores speed to its original value
func _ready() -> void:
	var old_speed = target.get_node("ChaseState").Chase_Speed
	target.get_node("ChaseState").Chase_Speed *= potency
	
	await get_tree().create_timer(duration).timeout
	
	target.get_node("ChaseState").Chase_Speed = old_speed
	queue_free()

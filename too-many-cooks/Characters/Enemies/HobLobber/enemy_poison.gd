extends Node

var target

var potency : int = 5

var duration : float = 5.0

##deletes itself after an amount of time decided by duration
func _ready():
	print("Poison!")
	target = get_parent() 
	await get_tree().create_timer(duration).timeout
	queue_free()

func _on_timer_timeout() -> void:
	target.health -= potency 
	if target.health <= 0: 
		target.change_state("death_state")

extends Area2D


##toggles hitbox on and off after every half second to hit enemies repeatedly
func _on_timer_timeout() -> void:
	monitoring = false
	monitorable = false
	
	await get_tree().create_timer(0.1).timeout
	
	monitoring = true
	monitorable = true

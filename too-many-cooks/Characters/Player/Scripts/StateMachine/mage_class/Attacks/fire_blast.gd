extends Area2D


##toggles hitbox on and off after half a second to hit enemies a second time
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	
	monitoring = false
	monitorable = false
	
	await get_tree().create_timer(0.1).timeout
	
	monitoring = true
	monitorable = true

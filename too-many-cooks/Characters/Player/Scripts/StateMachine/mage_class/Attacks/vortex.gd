extends StaticBody2D

var damage : int = 10

##sets the amount of damage the vortex should do per hit
func _ready() -> void:
	#damage = int(get_parent().strength * 1.2)
	pass


##adds any enemy who enters the vortex to the list
func _on_hitbox_area_entered(area: Area2D) -> void:
	area.get_parent().velocity += (global_position - area.get_parent().global_position).normalized() * 10


##flicks the hitbox on and off every second so the enemies inside take repeated damage
func _on_timer_timeout() -> void:
	$Hitbox.monitorable = false
	$Hitbox.monitoring = false
	
	$Hitbox.monitorable = true
	$Hitbox.monitoring = true


##vortex deletes itself after 5 seconds
func _on_duration_timer_timeout() -> void:
	queue_free()

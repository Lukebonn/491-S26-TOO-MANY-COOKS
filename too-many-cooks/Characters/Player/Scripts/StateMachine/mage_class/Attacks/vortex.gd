extends StaticBody2D

var damage : int = int(PlayerStats.base_str * 1.1)

var enemies : Array

##sets the amount of damage the vortex should do per hit
func _ready() -> void:
	#damage = int(get_parent().strength * 1.2)
	pass


##applies velocity over time that drags enemies towards the center of the vortex
func _process(delta: float) -> void:
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.velocity = (global_position - enemy.global_position).normalized() * 5000 * delta


##adds any enemy who enters the vortex to the list
func _on_hitbox_area_entered(area: Area2D) -> void:
	enemies.append(area.get_parent())


##removes any enemy who leaves the vortex from the list
func _on_hitbox_area_exited(area: Area2D) -> void:
	enemies.erase(area.get_parent())


##flicks the hitbox on and off every second so the enemies inside take repeated damage
func _on_timer_timeout() -> void:
	$Hitbox.monitorable = false
	$Hitbox.monitoring = false
	
	$Hitbox.monitorable = true
	$Hitbox.monitoring = true


##vortex deletes itself after 5 seconds
func _on_duration_timer_timeout() -> void:
	queue_free()

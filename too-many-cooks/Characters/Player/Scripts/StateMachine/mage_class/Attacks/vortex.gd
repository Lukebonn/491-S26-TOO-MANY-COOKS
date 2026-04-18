extends StaticBody2D

#var damage : int = int(PlayerStats.base_str * 1.1)

var enemies : Array

##sets the amount of damage the vortex should do per hit
#unused as vortex has been reworked and no longer does damage to enemies
func _ready() -> void:
	#damage = int(get_parent().strength * 1.2)
	pass


##applies velocity over time that drags enemies towards the center of the vortex
func _process(delta: float) -> void:
	for enemy in enemies:
		if(enemy.global_position != global_position):
			enemy.global_position += (global_position - enemy.global_position).normalized() * 55 * delta


##adds any enemy who enters the vortex to the list
func _on_hitbox_body_entered(body: Node2D) -> void:
	enemies.append(body)


##removes any enemy who leaves the vortex from the list
func _on_hitbox_body_exited(body: Node2D) -> void:
	enemies.erase(body)


##vortex deletes itself after 5 seconds
func _on_duration_timer_timeout() -> void:
	queue_free()

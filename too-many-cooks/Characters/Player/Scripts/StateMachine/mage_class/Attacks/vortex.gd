extends StaticBody2D

#var damage : int = int(PlayerStats.base_str * 1.1)

var enemies : Array

var force : int

##sets the amount of damage the vortex should do per hit
#unused as vortex has been reworked and no longer does damage to enemies
func _ready() -> void:
	if(PlayerStats.MageClassAbilityLevel >= 2):
		force = 100
	else:
		force = 55


##applies velocity over time that drags enemies towards the center of the vortex
func _process(delta: float) -> void:
	for enemy in enemies:
		if(enemy.global_position != global_position):
			enemy.global_position += (global_position - enemy.global_position).normalized() * force * delta


##adds any enemy who enters the vortex to the list
func _on_hitbox_body_entered(body: Node2D) -> void:
	enemies.append(body)


##removes any enemy who leaves the vortex from the list
func _on_hitbox_body_exited(body: Node2D) -> void:
	enemies.erase(body)


##vortex deletes itself after 5 seconds
func _on_duration_timer_timeout() -> void:
	queue_free()


##enemies in the vortex take damage every second
func _on_damage_tick_timer_timeout():
	for enemy in enemies:
		var damage : int = int(PlayerStats.player_ref.strength * 0.2)
		enemy.current_health -= damage
	
		var damage_number = preload("res://Characters/Enemies/Scenes/DamageNumber.tscn").instantiate()
		damage_number.Number = damage
		enemy.add_child(damage_number)
		
		if(enemy.current_health <= 0):
			enemy.change_state("DeathState")

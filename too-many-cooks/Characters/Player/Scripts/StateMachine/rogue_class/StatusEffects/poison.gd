extends Node2D

var target

var potency : int = int(PlayerStats.player_ref.strength / 2)

##reduces health by potency every second
#intantiates damage number effect over enemy
#if the enemy's health is reduced to 0, transition them to death state
func _on_timer_timeout() -> void:
	target.current_health -= potency
	
	var damage_number = preload("res://Characters/Enemies/Scenes/DamageNumber.tscn").instantiate()
	damage_number.Number = potency
	damage_number.self_modulate = Color(0, 1, 0)
	target.add_child(damage_number)
	
	if(target.current_health <= 0):
		target.change_state("DeathState")


##deletes itself after duration expires
func _on_duration_timer_timeout() -> void:
	queue_free()


##restarts duration timer
func refresh():
	$DurationTimer.start()
	potency = int(PlayerStats.player_ref.strength / 2)

extends Node

var target

var potency : int = 10

var duration : float = 10.0

##deletes itself after an amount of time decided by duration
func _ready():
	await get_tree().create_timer(duration).timeout
	queue_free()

##reduces health by potency every second
#intantiates damage number effect over enemy
#if the enemy's health is reduced to 0, transition them to death state
func _on_timer_timeout() -> void:
	target.current_health -= potency
	
	var damage_number = preload("res://Characters/Enemies/Scenes/DamageNumber.tscn").instantiate()
	damage_number.Number = potency
	target.add_child(damage_number)
	
	if(target.current_health <= 0):
		target.change_state("DeathState")

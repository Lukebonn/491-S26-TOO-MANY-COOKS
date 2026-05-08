extends Node2D

var target

var potency : float = 0.6

var old_speed

##saves target's orignal speed then reduces current speed by potency
func _ready() -> void:
	old_speed = target.get_node("ChaseState").Chase_Speed
	var damage_number = preload("res://Characters/Enemies/Scenes/DamageNumber.tscn").instantiate()
	damage_number.self_modulate = Color(0, 1, 1)
	target.get_node("ChaseState").Chase_Speed *= potency


##after duration passes, restores speed to its original value and node deletes itself
func _on_duration_timer_timeout() -> void:
	target.get_node("ChaseState").Chase_Speed = old_speed
	queue_free()


##restarts duration timer
func refresh():
	$DurationTimer.start()

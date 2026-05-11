extends Node2D

var target

var potency : float = 0.8

var old_damage
signal change_color
##saves target's orignal damage then reduces current damage by potency
func _ready() -> void:
	old_damage = target.damage
	change_color.emit()
	target.damage *= potency


##after duration passes, restores speed to its original value and node deletes itself
func _on_duration_timer_timeout() -> void:
	target.damage = old_damage
	queue_free()


##restarts duration timer
func refresh():
	$DurationTimer.start()

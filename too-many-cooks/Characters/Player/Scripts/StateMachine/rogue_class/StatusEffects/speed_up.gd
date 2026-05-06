extends Node2D

var target

var potency : float = 0.2

var stack : int = 1

var old_speed

##saves the player's original speed and then increases it
func _ready() -> void:
	old_speed = target.speed
	set_speed()


##sets the player's speed to their normal speed increased by 20% per stack
func set_speed():
	target.speed = old_speed * (1 + potency * stack)


##resets the duration timer, increases stack by one, and sets new speed
func refresh():
	$DurationTimer.start()
	stack += 1
	set_speed()


##returns player's speed to normal and deletes itself after duration expires
func _on_duration_timer_timeout() -> void:
	target.speed = old_speed
	queue_free()

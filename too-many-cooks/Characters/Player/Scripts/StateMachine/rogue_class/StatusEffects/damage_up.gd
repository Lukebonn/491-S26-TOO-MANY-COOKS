extends Node2D

var target

var potency : float = 0.2

var stack : int = 1

var old_strength

##saves the player's original strength and then increases it
func _ready() -> void:
	old_strength = target.strength
	set_strength()


##sets the player's strength to their normal strength increased by 20% per stack
func set_strength():
	target.strength = old_strength * (1 + potency * stack)


##resets the duration timer, increases stack by one, and sets new strength
func refresh():
	$DurationTimer.start()
	stack += 1
	set_strength()

##returns player's speed to normal and deletes itself after duration expires
func _on_duration_timer_timeout() -> void:
	target.strength = old_strength
	queue_free()

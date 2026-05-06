extends Node2D

var target

var stack : int = 1

var potency : int = int(PlayerStats.MaxHealth * 0.1)

##heals target by 10% of their max hp for each stack of regen they have
func _on_heal_tick_timer_timeout() -> void:
	target.health += potency * stack


##deletes itself after duration expires
func _on_duration_timer_timeout() -> void:
	queue_free()


##restarts timer and increases stack by 1
func refresh():
	$DurationTimer.start()
	stack += 1

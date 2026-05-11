extends Area2D

##damage ticks faster if ability is upgraded
func _ready():
	if(PlayerStats.MageClassAbilityLevel >= 3):
		$Timer.wait_time = 0.5
		$Timer.start()
	else:
		$Timer.wait_time = 0.75
		$Timer.start()


##toggles hitbox on and off after every half second to hit enemies repeatedly
func _on_timer_timeout() -> void:
	monitoring = true
	monitorable = true
	
	await get_tree().create_timer(0.1).timeout
	
	monitoring = false
	monitorable = false

extends Enemy

signal onEnemyDeath()
var playerNear = false
var enraged = false

func _on_near_zone_area_entered(area: Area2D) -> void:
	playerNear = true

func _on_near_zone_area_exited(area: Area2D) -> void:
	playerNear = false

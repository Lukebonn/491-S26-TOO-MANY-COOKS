extends Enemy
# hawk one: what are you thinking of getting?
# hawk two: uhh.
# hawk one: always so indecisive.
signal onEnemyDeath()
var playerNear = false


func _on_near_zone_area_entered(area: Area2D) -> void:
	playerNear = true

func _on_near_zone_area_exited(area: Area2D) -> void:
	playerNear = false

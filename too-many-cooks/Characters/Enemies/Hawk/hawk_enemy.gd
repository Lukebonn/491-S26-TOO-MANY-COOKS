extends Enemy
# hawk one: what are you thinking of getting?
# hawk two: uhh.
# hawk one: always so indecisive.
signal onEnemyDeath()
var playerNear = false
var colliding_with_wall = false


func _on_near_zone_area_entered(area: Area2D) -> void:
	playerNear = true

func _on_near_zone_area_exited(area: Area2D) -> void:
	playerNear = false

func _on_wall_detector_body_entered(body: Node2D) -> void:
	print("colliding")
	colliding_with_wall = true

func _on_wall_detector_body_exited(body: Node2D) -> void:
	print("not colliding")
	colliding_with_wall = false

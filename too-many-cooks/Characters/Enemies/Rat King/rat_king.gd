extends Enemy

signal onEnemyDeath()
var playerNear = false
@export var enraged = false

func _on_near_zone_area_entered(area: Area2D) -> void:
	playerNear = true

func _on_near_zone_area_exited(area: Area2D) -> void:
	playerNear = false


func _on_obj_enemy_spawner_on_all_dead():
	$Hurtbox/CollisionShape2D.set_deferred("disabled", false)

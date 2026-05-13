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

func _on_room_start() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func _on_spawned_enemy_killed() -> void:
	enraged = true
	# now THIS is where the fun begins.

#extends Enemy
#
#signal onEnemyDeath()
#
#var playerNear = false
#
#func _on_near_zone_area_entered(area: Area2D) -> void:
	#playerNear = true
#
#func _on_near_zone_area_exited(area: Area2D) -> void:
	#playerNear = false

extends Enemy

signal onEnemyDeath()

@export var smash_range := 32.0
@export var smash_state_name := "HitState"

var playerNear = false

func _physics_process(delta: float) -> void:
	if not playerNear:
		return

	if player_ref == null:
		return

	var distance_to_player := global_position.distance_to(player_ref.global_position)

	if distance_to_player <= smash_range:
		velocity = Vector2.ZERO
		change_state(smash_state_name)

func _on_near_zone_area_entered(area: Area2D) -> void:
	playerNear = true

	var possible_player := area.get_parent()
	if possible_player and possible_player.is_in_group("Player"):
		player_ref = possible_player

func _on_near_zone_area_exited(area: Area2D) -> void:
	var possible_player := area.get_parent()
	if possible_player == player_ref:
		playerNear = false
		player_ref = null

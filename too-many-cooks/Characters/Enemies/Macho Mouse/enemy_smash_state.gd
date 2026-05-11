extends EnemyState

@export var windup_time: float = 0.6
@export var smash_duration: float = 0.4
@export var pause_after_smash: float = 1.0

func enter_state(enemy_node):
	super(enemy_node)
	enemy_ref.can_smash = false
	enemy_ref.is_smashing = false
	enemy_ref.set_hitbox_active(false)
	enemy_ref.velocity = Vector2.ZERO
	enemy_ref.move_and_slide()
	
	enemy_ref.show_attack_warning()
	
	var sprite = enemy_ref.get_node("AnimatedSprite2D")
	sprite.play("windup")
	await get_tree().create_timer(windup_time).timeout
	sprite.play("smash")
	enemy_ref.hide_attack_warning()
	enemy_ref.is_smashing = true
	enemy_ref.set_hitbox_active(true)
	
	await get_tree().create_timer(smash_duration).timeout
	
	enemy_ref.is_smashing = false
	enemy_ref.set_hitbox_active(false)
	enemy_ref.velocity = Vector2.ZERO
	enemy_ref.move_and_slide()

	await get_tree().create_timer(pause_after_smash).timeout

	if enemy_ref.has_method("reset_smash"):
		enemy_ref.reset_smash()

	if enemy_ref.current_health <= 0:
		enemy_ref.change_state("DeathState")
		return
	elif enemy_ref.player_in_sight:
		enemy_ref.change_state("ChaseState")
	else:
		enemy_ref.change_state("IdleState")

func process(_delta):
	enemy_ref.velocity = Vector2.ZERO
	enemy_ref.move_and_slide()

func hit_response(_source):
	enemy_ref.is_smashing = false
	enemy_ref.set_hitbox_active(false)
	enemy_ref.hide_attack_warning()
	enemy_ref.can_smash = true
	enemy_ref.change_state("HitState")

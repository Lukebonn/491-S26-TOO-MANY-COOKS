extends EnemyState
# Enemy swipes in the direction of the player, dealing damage.

@export var state_to_enter: Node

func enter_state(enemy_node):
	super(enemy_node)
	await get_tree().create_timer(0.3).timeout
	$"../Slash Hitbox".show()
	$"../Slash Hitbox".process_mode = Node.PROCESS_MODE_INHERIT
	$"../Slash Hitbox".look_at(Vector2(player_ref.position.x, player_ref.position.y))
	await get_tree().create_timer(0.1).timeout
	$"../Slash Hitbox".hide()
	$"../Slash Hitbox".process_mode = Node.PROCESS_MODE_DISABLED
	exit_state()

func hit_response(source):
	$"../Slash Hitbox".hide()
	$"../Slash Hitbox".process_mode = Node.PROCESS_MODE_DISABLED
	enemy_ref.change_state("HitState")

func exit_state():
	$"../Slash Hitbox".hide()
	$"../Slash Hitbox".process_mode = Node.PROCESS_MODE_DISABLED
	if state_to_enter:
		enemy_ref.change_state(str(state_to_enter))
	else:
		enemy_ref.change_state("IdleState")

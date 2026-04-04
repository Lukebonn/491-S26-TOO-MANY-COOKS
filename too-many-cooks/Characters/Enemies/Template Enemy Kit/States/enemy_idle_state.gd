extends EnemyState
#this state idles (does nothing, aside from an animation if set up)

func enter_state(enemy_node):
	super(enemy_node)
	enemy_ref.velocity = Vector2(0,0)
	if enemy_ref.player_in_sight:
		enemy_ref.change_state(str(enemy_ref.sight_state))

func hit_response(source):
	enemy_ref.change_state("HitState")

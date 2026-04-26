extends EnemyState
#it's like idlestate but does even less

func enter_state(enemy_node):
	super(enemy_node)
	enemy_ref.velocity = Vector2(0,0)

func hit_response(source):
	enemy_ref.change_state("HitState")

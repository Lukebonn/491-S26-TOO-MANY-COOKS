extends EnemyState
#unimplemented so far

func enter_state(enemy_node):
	super(enemy_node)

func hit_response(source):
	enemy_ref.change_state("HitState")

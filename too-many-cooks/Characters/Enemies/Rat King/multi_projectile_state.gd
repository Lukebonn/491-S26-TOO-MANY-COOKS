extends EnemyState


func enter_state(enemy_node):
	super(enemy_node)
	#await get_tree().create_timer(0.3).timeout

func process(_delta):
	$"../RegularProjectileLines".look_at(Vector2(player_ref.position.x, player_ref.position.y))
	

extends EnemyState
# this state does nothing

func enter_state(enemy_node):
	super(enemy_node)

func process(_delta):
	if player_ref and enemy_ref:
		if not player_ref.dead:
			var direction = enemy_ref.get_player_vector()
			if(direction.x < 0):
				enemy_ref.get_node("AnimatedSprite2D").flip_h = false
			if(direction.x > 0):
				enemy_ref.get_node("AnimatedSprite2D").flip_h = true

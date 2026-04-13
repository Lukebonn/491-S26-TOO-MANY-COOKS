extends PlayerState

func enter_state(player_node):
	print_debug("death_state entered")
	super(player_node)
	
	player.visible = false
	player.velocity = Vector2(0,0)
	player.dead = true
	get_parent().playerDeath.emit()

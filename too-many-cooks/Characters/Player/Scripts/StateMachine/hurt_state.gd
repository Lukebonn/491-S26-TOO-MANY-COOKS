extends PlayerState

func enter_state(player_node):
	print_debug("hurt_state entered")
	super(player_node)
	
	player.change_state("move_state")

extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.change_state("move_state")

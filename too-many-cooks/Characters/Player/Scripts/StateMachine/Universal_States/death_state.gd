extends PlayerState

signal combat_music_stop
func enter_state(player_node):
	print_debug("death_state entered")
	super(player_node)
	
	player.get_node("Sprite2D").animation = "death"
	player.velocity = Vector2(0,0)
	await player.get_node("Sprite2D").animation_finished
	player.dead = true
	get_parent().playerDeath.emit()
	player.process_mode = Node.PROCESS_MODE_DISABLED
	combat_music_stop.emit()

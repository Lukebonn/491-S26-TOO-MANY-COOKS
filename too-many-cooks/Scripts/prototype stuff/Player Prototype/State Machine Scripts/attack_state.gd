extends PlayerState


##Calls player_state enter_state method to have 'player' reference player node
func enter_state(player_node):
	print_debug("attack_state entered")
	super(player_node)
	
	#player lunges forward a small amount and has their hitbox enabled
	player.velocity += player.local_mouse_pos.normalized() * 200
	$"../Hitbox".monitorable = true
	await get_tree().create_timer(0.1).timeout
	
	#player stops for a moment after attacking and has their hitbox disabled
	player.velocity = Vector2(0,0)
	$"../Hitbox".monitorable = false
	await get_tree().create_timer(0.1).timeout
	
	player.change_state("idle_state")


func input_handler(_delta : float) -> void:
	pass

##player should lose a certain amount of health
func hit_response(source):
	pass #add damage code

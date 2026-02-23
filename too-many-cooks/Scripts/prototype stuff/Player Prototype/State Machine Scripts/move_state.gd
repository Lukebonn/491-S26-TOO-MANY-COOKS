extends PlayerState


# Called when the node enters the scene tree for the first time.
func enter_state(player_node):
	print_debug("move_state entered")
	super(player_node)


func input_handler(_delta : float) -> void:
	if(Input.is_action_pressed("move_up")):
		player.velocity.y = -1 * player.speed
	elif(Input.is_action_pressed("move_down")):
		player.velocity.y = 1 * player.speed
	else:
		player.velocity.y = 0
	
	if(Input.is_action_pressed("move_left")):
		player.velocity.x = -1 * player.speed
	elif(Input.is_action_pressed("move_right")):
		player.velocity.x = 1 * player.speed
	else:
		player.velocity.x = 0
	
	player.velocity = player.velocity.normalized() * player.speed
	
	#changes to idle_state if player is not moving
	if(player.velocity == Vector2(0,0)):
		player.change_state("idle_state")
	
	if(Input.is_action_just_pressed("dash")):
		player.change_state("dash_state")

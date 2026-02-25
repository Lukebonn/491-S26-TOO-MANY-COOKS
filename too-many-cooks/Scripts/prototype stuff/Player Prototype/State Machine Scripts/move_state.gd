extends PlayerState


##Calls player_state enter_state method to have 'player' reference player node
func enter_state(player_node):
	print_debug("move_state entered")
	super(player_node)

func input_handler(_delta : float) -> void:
	player.current_dir = player.velocity
	
	player.velocity = Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down"))
	player.velocity = player.velocity.normalized() * player.speed
	
	#changes to idle_state if player is not moving
	if(player.velocity == Vector2(0,0)):
		player.change_state("idle_state")
	
	#changes to dash state if dash key is pressed
	if(Input.is_action_just_pressed("dash")):
		player.change_state("dash_state")
	
	#changes to attack_state if attack input is pressed
	if(Input.is_action_just_pressed("attack")):
		player.change_state("attack_state")

##player should lose a certain amount of health
func hit_response(source):
	pass #replace with damage code

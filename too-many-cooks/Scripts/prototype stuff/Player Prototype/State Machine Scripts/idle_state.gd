extends PlayerState


##Calls player_state enter_state method to have 'player' reference player node
func enter_state(player_node):
	print_debug("idle_state entered")
	super(player_node)

func input_handler(_delta : float) -> void:
	#changes to move_state if movement inputs are pressed
	if(Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down")) != Vector2(0,0)):
		player.change_state("move_state")
	
	#changes to dash_state if dash input is pressed
	if(Input.is_action_just_pressed("dash")):
		player.change_state("dash_state")
	
	#changes to attack_state if attack input is pressed
	if(Input.is_action_just_pressed("attack")):
		player.change_state("attack_state")

##player should lose a certain amount of health
func hit_response(source):
	pass #replace with damage code

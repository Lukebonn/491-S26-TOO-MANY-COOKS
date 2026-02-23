extends PlayerState

# Called when the node enters the scene tree for the first time.
func enter_state(player_node):
	print_debug("idle_state entered")
	super(player_node)

func input_handler(_delta : float) -> void:
	#changes to move_state if movement inputs are pressed
	if(Input.is_action_just_pressed("move_up") or
	Input.is_action_just_pressed("move_down") or
	Input.is_action_just_pressed("move_right") or
	Input.is_action_just_pressed("move_left")):
		player.change_state("move_state")
	
	#changes to dash_state if dash input is pressed
	if(Input.is_action_just_pressed("dash")):
		player.change_state("dash_state")

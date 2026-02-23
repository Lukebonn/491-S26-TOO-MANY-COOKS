extends PlayerState

var dash_speed : int = 1000
var duration : float = 0.2
var timer : float

##Calls player_state enter_state method to have 'player' reference player node
#sets players speed to dash_speed, resets duration timer
func enter_state(player_node):
	print_debug("dash_state entered")
	super(player_node)
	
	#player will dash in the last recorded direction if not moving
	if(player.velocity == Vector2(0,0)):
		player.velocity = player.current_dir
	else:
		player.velocity = Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down"))
	player.velocity = player.velocity.normalized() * dash_speed
	
	timer = duration

##changes into move_state when timer reaches zero
func input_handler(delta : float) -> void:
	if(timer > 0):
		timer -= delta
	else:
		player.change_state("move_state")

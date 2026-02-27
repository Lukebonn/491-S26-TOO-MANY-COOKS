extends PlayerState

var dash_speed : int = 1000
var duration : float = 0.2
var timer : float

var dash_counter : int = 0
var cooldown : float = 1.0
var cooldown_timer : float = 0

##Calls player_state enter_state method to have 'player' reference player node
#sets players speed to dash_speed, resets duration timer
func enter_state(player_node):
	print_debug("dash_state entered")
	super(player_node)
	
	#checks if the player is spamming dash
	if(cooldown_timer > 0):
		dash_counter += 1
		reset_cooldown()
	else:
		dash_counter = 0
		dash_speed = 1000
	
	#if the player has spammed dash 3 times, their dash will slow way down
	if(dash_counter >= 3):
		dash_speed /= dash_counter
	
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
		player.change_state("idle_state")
		start_cooldown(delta)

##starts a timer that keeps track of if the player is spamming dash
func start_cooldown(delta : float):
	cooldown_timer = cooldown
	
	while cooldown_timer > 0:
		cooldown_timer -= delta
		await get_tree().process_frame

func reset_cooldown():
	cooldown_timer = cooldown

##player should not take damage in roll state
func hit_response(_source):
	pass

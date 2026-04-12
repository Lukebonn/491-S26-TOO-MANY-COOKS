extends PlayerState

var full_dash_speed : int = 400
var current_dash_speed : int

var duration : float = 0.1
var timer : float

var dash_counter : int = 0
var cooldown : float = 2
var cooldown_timer : Timer = Timer.new()

var first_time : bool = true

signal player_in_hitbox(Area2D)

##Calls player_state enter_state method to have 'player' reference player node
#sets players speed to dash_speed, resets duration timer
func enter_state(player_node):
	#print_debug("dash_state entered")
	super(player_node)
	
	player.play_sound(load("res://Audio/Sounds/Player/BlankClass/dash.mp3"))
	
	current_dash_speed = full_dash_speed
	
	if(first_time):
		player.add_child(cooldown_timer)
		cooldown_timer.timeout.connect(reset_counter)
		
		first_time = false
	
	#checks if the player is spamming dash
	if(!cooldown_timer.is_stopped()):
		dash_counter += 1
	
	#if the player has spammed dash 3 times, their dash will slow way down
	if(dash_counter >= 3):
		player.modulate = Color(1.0, 0.639, 0.19, 1.0)
		current_dash_speed /= dash_counter
	
	#player will dash in the last recorded direction if not moving
	if(player.velocity == Vector2(0,0)):
		player.velocity = player.current_dir
	else:
		player.velocity = Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down"))
	player.velocity = player.velocity.normalized() * current_dash_speed
	
	timer = duration

##changes into move_state when timer reaches zero
func input_handler(delta : float) -> void:
	if(timer > 0):
		timer -= delta
	else:
		player.change_state("idle_state")

##player hurtbox is flicked on and off once dash ends so that it will check for collisions
func exit_state():
	$"../Hurtbox".monitoring = false
	$"../Hurtbox".monitoring = true
	start_cooldown()

##starts a timer that keeps track of if the player is spamming dash
func start_cooldown():
	cooldown_timer.start()
	
	player.modulate = Color(1.0, 1.0, 1.0, 1.0)

func reset_counter():
	cooldown_timer.stop()
	dash_counter = 0

##player should not take damage in dash state
func hit_response(_source):
	pass

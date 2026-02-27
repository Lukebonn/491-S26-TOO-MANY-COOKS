extends PlayerState

var cooldown : float = 0.5
var on_cooldown : bool = false

##Calls player_state enter_state method to have 'player' reference player node
func enter_state(player_node):
	print_debug("attack_state entered")
	super(player_node)
	
	if(!on_cooldown):
		#player lunges forward a small amount and has their hitbox enabled
		player.velocity += player.local_mouse_pos.normalized() * 300
		$"../Hitbox".monitorable = true
		await get_tree().create_timer(0.1).timeout
		
		#player stops for a moment after attacking and has their hitbox disabled
		$"../Hitbox".monitorable = false
		player.velocity = Vector2(0,0)
		
		start_cooldown()
	
	player.change_state("move_state")


func input_handler(_delta : float) -> void:
	pass

##player is unable to attack until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

##player should lose a certain amount of health
func hit_response(source):
	pass #add damage code and change to hurt state

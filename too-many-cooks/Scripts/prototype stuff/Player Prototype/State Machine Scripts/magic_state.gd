extends PlayerState

var cooldown : float = 0.5
var on_cooldown : bool = false

##Calls player_state enter_state method to have 'player' reference player node
func enter_state(player_node):
	print_debug("magic_state entered")
	super(player_node)

##creates an instance of the spell and sets its velocity in the direction the player is aiming
func input_handler(delta : float) -> void:
	
	#spell only activates if cooldown has expired
	if(!on_cooldown):
		var spell = preload("res://Scripts/prototype stuff/Player Prototype/magic_default.tscn").instantiate()
		spell.position = player.position
		spell.velocity = player.local_mouse_pos.normalized() * 10
		add_child(spell)
		
		start_cooldown()
	
	player.change_state("idle_state")

#makes the player unable to use the spell again until the cooldown has expired
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

##player should lose a certain amount of health
func hit_response(source):
	pass #add damage code and change to hurt state

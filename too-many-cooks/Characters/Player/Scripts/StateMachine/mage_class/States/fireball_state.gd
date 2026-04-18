extends PlayerState

var blast = load("res://Characters/Player/Scripts/StateMachine/mage_class/Attacks/fire_blast.tscn")

var this_blast

func enter_state(player_node):
	super(player_node)
	
	#creates fire blast scene and adds it to the player
	this_blast = blast.instantiate()
	player.add_child(this_blast)
	this_blast.position = Vector2.ZERO
	
	player.set_damage(2.5)
	
	#print_debug("fire state entered")

##mana drains over time while player is in this state, transitons to move_state when right click is released
func input_handler(delta : float) -> void:
	player.mana -= 20 * delta
	
	player.velocity = Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down"))
	player.velocity = player.velocity.normalized() * ((player.speed * player.speed_mult) / 1.5)
	
	if(Input.is_action_just_released("magic") or player.mana <= 0):
		
		player.change_state("move_state")


##blast is deleted upon leaving the state
func exit_state():
	this_blast.queue_free()

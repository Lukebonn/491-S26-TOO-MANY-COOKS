extends PlayerState

var mana_cost : int= 10

var teleport_vector : Vector2


##player should teleport a certain distance
#distance traveled scales on speed
#teleport vector should stop at walls (not sure how I'm going to do that yet)
func enter_state(player_node):
	super(player_node)
	
	teleport_vector = player.global_position + player.velocity.normalized() * (player.speed / 2)
	player.global_position = teleport_vector
	player.mana -= mana_cost
	
	player.change_state("move_state")


##player hurtbox is flicked on and off once dash ends so that it will check for collisions
func exit_state():
	$"../Hurtbox".monitoring = false
	$"../Hurtbox".monitoring = true


##player should not take damage in dash state
func hit_response(_source):
	pass

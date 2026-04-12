extends PlayerState

var mana_cost : int = 10

var teleport_vector : Vector2


##player should teleport a certain distance
#distance traveled scales on speed
#teleport vector should stop at walls
func enter_state(player_node):
	super(player_node)
	
	if(player.mana >= mana_cost):
		
		player.play_sound(load("res://Audio/Sounds/Player/BlankClass/dash.mp3"))
		
		if(player.velocity == Vector2(0,0)):
			teleport_vector = player.global_position + player.current_dir.normalized() * 50
		else:
			teleport_vector = player.global_position + player.velocity.normalized() * 50
		
		
		var raycast = RayCast2D.new()
		
		raycast.set_collision_mask_value(7, true)
		
		player.add_child(raycast)
		
		raycast.target_position = teleport_vector
		
		
		if(raycast.is_colliding()):
			print_debug("raycast collision")
			teleport_vector = raycast.get_collision_point()
		
		player.global_position = teleport_vector
		player.mana -= mana_cost
		
		raycast.queue_free()
	
	player.change_state("move_state")


##player hurtbox is flicked on and off once dash ends so that it will check for collisions
func exit_state():
	$"../Hurtbox".monitoring = false
	$"../Hurtbox".monitoring = true


##player should not take damage in dash state
func hit_response(_source):
	pass

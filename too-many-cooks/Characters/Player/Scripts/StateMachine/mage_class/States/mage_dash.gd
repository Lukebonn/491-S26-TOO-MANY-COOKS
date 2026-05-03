extends PlayerState

var mana_cost : int = 10

var teleport_vector : Vector2


##player should teleport a certain distance
#distance traveled scales on speed
#teleport vector should stop at walls
func enter_state(player_node):
	super(player_node)
	
	PlayerStats.has_not_dashed = false
	
	if(player.mana >= mana_cost):
		
		player.play_sound(load("res://Audio/Sounds/Player/BlankClass/dash.mp3"))
		
		if(player.velocity == Vector2(0,0)):
			teleport_vector = player.position + player.current_dir.normalized() * 50
		else:
			teleport_vector = player.position + player.velocity.normalized() * 50
		
		
		player.get_node("RayCast2D").target_position = player.velocity.normalized() * 50
		
		await get_tree().process_frame
		
		if(player.get_node("RayCast2D").is_colliding()):
			print_debug("raycast collision")
			teleport_vector = player.get_node("RayCast2D").get_collision_point()
		
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

extends PlayerState

var damage_hitbox : Area2D

func enter_state(player_node):
	#print_debug("hurt_state entered")
	super(player_node)
	
	#player takes an amount of damage equal to the attacker's attack power
	player.health -= damage_hitbox.get_parent().damage
	
	#player receives knockback on hit
	player.velocity = (damage_hitbox.get_parent().velocity - player.velocity).normalized() * 350
	
	await get_tree().create_timer(0.1).timeout
	
	#player dies if their health is below zero, otherwise is returned to move_state
	#to be replaced with something fancier in the future
	if(player.health <= 0):
		player.change_state("death_state")
	else:
		player.change_state("move_state")

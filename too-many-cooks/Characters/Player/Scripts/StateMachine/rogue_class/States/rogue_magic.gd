extends PlayerState

##sets the status effect that is applied by rogue attack to the player's currently selected status
func enter_state(player_node):
	super(player_node)
	
	#won't change the status or deplete mana if the player already has their equipped status active
	if(player.get_node("attack_state").equipped_status != player.get_node("attack_state").active_status):
		player.get_node("attack_state").active_status = player.get_node("attack_state").equipped_status
		
		player.mana -= 35
	
	player.change_state("move_state")

##player should lose a certain amount of health
func hit_response(source):
	$"../hurt_state".damage_hitbox = source
	player.change_state("hurt_state")

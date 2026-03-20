extends PlayerState

var cooldown : int
var on_cooldown : bool = false

var parrying : bool = false

##player will enter into an attack depending on how many normal attacks were executed right before
func enter_state(player_node):
	super(player_node)
	
	if(!on_cooldown):
		
		match player.get_node("attack_state").combo_counter:
			0:
				if(player.mana >= 10):
					await parry()
					
			_:
				pass
	
	start_cooldown()
	player.change_state("move_state")

##parry: player cannot be hit and will damage attackers for a quarter second
func parry():
	parrying = true
	player.mana -= 10
	player.modulate = Color(0.674, 1.0, 0.901, 1.0)
	
	await get_tree().create_timer(0.25).timeout
	
	player.modulate = Color(1.0, 1.0, 1.0, 1.0)
	parrying = false

##player is unable to use the spell again until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

##player should lose a certain amount of health
func hit_response(source):
	if(parrying):
		source.get_parent().take_damage(20, player.position)
	else:
		$"../hurt_state".damage_hitbox = source
		player.change_state("hurt_state")

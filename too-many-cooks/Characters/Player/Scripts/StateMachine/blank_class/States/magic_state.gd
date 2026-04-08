extends PlayerState

var cooldown : float = 1.0
var on_cooldown : bool = false

var mana_cost : float = 30

##Calls player_state enter_state method to have 'player' reference player node
func enter_state(player_node):
	#print_debug("magic_state entered")
	super(player_node)
	
	#spell only activates if cooldown has expired
	if(!on_cooldown and player.mana >= mana_cost):
		var spell
		
		spell = preload("res://Objects/Projectiles/magic_default.tscn").instantiate()
		player.add_child(spell)
		spell.position += player.local_mouse_pos.normalized() * 15
		spell.velocity = player.local_mouse_pos.normalized() * 5
		player.mana -= mana_cost
		
		start_cooldown()
	elif (player.mana < mana_cost):
		get_parent().notEnoughMana.emit()
	# Dawson - If the player can't cast their spell, this conditional
	# will check if its because they do not have enough Mana to do so.
	# This will be used to make the Mana bar flash to indicate to the
	# player that they do not have enough Mana to cast their spell.
	
	player.change_state("move_state")

##player is unable to use the spell again until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

##player should lose a certain amount of health
func hit_response(source):
	$"../hurt_state".damage_hitbox = source
	player.change_state("hurt_state")

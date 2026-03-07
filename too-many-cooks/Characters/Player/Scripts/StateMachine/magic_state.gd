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
		#magic logic gets from stats for what spell to cast
		#we might move more of the spell logic into the match statement
		#since things like fireball only really need velocity and stuff
		#and these spells will likely have separate magic costs
		match PlayerStats.Magic:
			"None":
				pass
			"Fireball":
				spell = preload("res://Objects/Projectiles/magic_default.tscn").instantiate()
				spell.position = player.position + player.local_mouse_pos.normalized() * 15
				spell.velocity = player.local_mouse_pos.normalized() * 5
				add_child(spell)
				player.mana -= mana_cost
			"Regen":
				pass
		
		start_cooldown()
	elif (player.mana < mana_cost):
		get_parent().notEnoughMana.emit()
	# Dawson - If the player can't cast their spell, this conditional
	# will check if its because they do not have enough Mana to do so.
	# This will be used to make the Mana bar flash to indicate to the
	# player that they do not have enough Mana to cast their spell.
	
	player.change_state("move_state")

##creates an instance of the spell and sets its velocity in the direction the player is aiming
func input_handler(_delta : float) -> void:
	pass

##player is unable to use the spell again until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

##player should lose a certain amount of health
func hit_response(source):
	$"../hurt_state".damage_hitbox = source
	player.change_state("hurt_state")

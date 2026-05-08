extends PlayerState

var damage_hitbox : Area2D
@export var Hurt_Sound: AudioStreamPlayer

var invincible : bool = false

func enter_state(player_node):
	#print_debug("hurt_state entered")
	super(player_node)
	
	#player shouldn't get hit if invincible is true
	if(!invincible):
		if Hurt_Sound:
			Hurt_Sound.play()
		
		player.get_node("Sprite2D").animation = "hurt"
		#player.modulate = Color(1.0, 0.382, 0.452, 1.0)
		
		
		#player takes an amount of damage equal to the attacker's attack power
		var dmg = damage_hitbox.get("damage")
		if dmg == null:
			dmg = damage_hitbox.get_parent().get("damage")
		if dmg != null:
			player.health -= dmg
			PlayerStats.Enemy_Damage_Dealt += dmg
		
		
		#player receives knockback on hit
		player.velocity = (player.global_position - damage_hitbox.get_parent().global_position).normalized() * 350
		await get_tree().create_timer(0.1).timeout
		
		#player dies if their health is below zero, otherwise is returned to move_state
		#to be replaced with something fancier in the future
		if(player.health <= 0):
			player.change_state("death_state")
		else:
			#player.modulate = Color(1.0, 1.0, 1.0, 1.0)
			player.change_state("move_state")
			inv_timer()
	else:
		player.change_state("move_state")
	


##sets a timer that the player cannot be hit for
#switches the player's hitbox on and off so that they will be hit again once they are vulnerable
func inv_timer():
	invincible = true
	
	await get_tree().create_timer(1).timeout
	
	invincible = false
	
	$"../Hurtbox".monitoring = false
	$"../Hurtbox".monitoring = true

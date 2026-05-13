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
				if(player.mana >= 20):
					await parry()
				else:
					get_parent().notEnoughMana.emit()
			1:
				if(player.mana >= 35):
					sword_projectile()
				else:
					get_parent().notEnoughMana.emit()
			2:
				if(player.mana >= 55):
					spin_attack()
				else:
					get_parent().notEnoughMana.emit()
	
	start_cooldown()
	player.change_state("move_state")

##parry: player cannot be hit and will damage attackers for a quarter second
func parry():
	parrying = true
	player.velocity = Vector2.ZERO
	player.mana -= 20
	player.modulate = Color(0.674, 1.0, 0.901, 1.0)
	player.play_sound(load("res://Audio/Sounds/Player/Warrior/Parry noise.mp3"))
	parry_sword_anim()
	await get_tree().create_timer(0.4).timeout
	player.modulate = Color(1.0, 1.0, 1.0, 1.0)
	parrying = false

func parry_sword_anim() -> void:
	#Rotates player weapon when parry is used; transferred Tyler's code from player_state_handler to here.
	var ref = $"../Weapon/Sprite2D"
	ref.flip_h = true
	ref.position = Vector2(4.0, 0.0)
	await get_tree().create_timer(0.4).timeout
	ref.flip_h = false
	ref.position = Vector2(14.0, 0.0)

func sword_projectile():
	var attack = preload("res://Objects/Projectiles/magic_sword_projectile.tscn").instantiate()
	get_tree().get_root().add_child(attack)
	attack.global_position = player.global_position + player.local_mouse_pos.normalized() * 15
	attack.velocity = player.local_mouse_pos.normalized() * 2
	
	player.mana -= 35
	
	await get_tree().create_timer(1, false).timeout
	
	if(attack):
		attack.queue_free()

func spin_attack():
	
	var attack = preload("res://Characters/Player/Scripts/StateMachine/warrior_class/Attacks/warrior_spin_attack.tscn").instantiate()
	player.add_child(attack)
	
	#player.velocity = Vector2.ZERO
	
	player.mana -= 55
	
	#player.set_damage(1.8)
	
	if(PlayerStats.MeleeClassAbilityLevel >= 3):
		await get_tree().create_timer(1.0, false).timeout
	else:
		await get_tree().create_timer(0.5, false).timeout
	
	attack.queue_free()
	

##player is unable to use the spell again until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

##player should lose a certain amount of health
#if parrying, the enemy will take damage instead
#if parry is upgraded, it will cause a damaging aoe instead of hitting the attacking enemy
func hit_response(source):
	if(parrying):
		if(PlayerStats.MeleeClassAbilityLevel >= 1):
			var aoe = load("res://Characters/Player/Scripts/StateMachine/warrior_class/Attacks/parry_aoe.tscn").instantiate()
			player.add_child(aoe)
			aoe.position = Vector2.ZERO
			player.set_damage(1.7)
			await get_tree().create_timer(0.1).timeout
			aoe.queue_free()
		else:
			source.get_parent().take_damage(int(player.strength * 1.7))
	else:
		$"../hurt_state".damage_hitbox = source
		player.change_state("hurt_state")

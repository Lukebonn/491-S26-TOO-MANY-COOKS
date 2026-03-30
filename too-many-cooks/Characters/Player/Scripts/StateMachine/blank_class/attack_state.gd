extends PlayerState

var attack : PackedScene = load("res://Characters/Player/Attacks/blank_class/blank_attack.tscn")

var power : float = 1.0

var cooldown : float = 0.3
var on_cooldown : bool = false

var mana_gain : float = 10

##Calls player_state enter_state method to have 'player' reference player node
func enter_state(player_node):
	#print_debug("attack_state entered")
	super(player_node)
	
	if(!on_cooldown):
		#player lunges forward a small amount and has their hitbox enabled
		player.velocity += player.local_mouse_pos.normalized() * 70
		
		var hitbox = attack.instantiate()
		hitbox.connect("body_entered", on_attack_hit)
		
		player.add_child(hitbox)
		hitbox.look_at(player.global_mouse_pos)
		
		player.set_damage(power)
		
		await get_tree().create_timer(0.1).timeout
		
		#player has their hitbox disabled
		
		hitbox.queue_free()
		
		player.velocity = Vector2(0,0)
		
		start_cooldown()
	
	player.change_state("move_state")


##player is unable to attack until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

##player regains mana when attacking enemies
func on_attack_hit(_body):
	player.mana += mana_gain

##player should lose a certain amount of health
func hit_response(source):
	$"../hurt_state".damage_hitbox = source
	player.change_state("hurt_state")

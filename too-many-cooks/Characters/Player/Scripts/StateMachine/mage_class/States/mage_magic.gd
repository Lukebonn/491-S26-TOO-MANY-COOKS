extends PlayerState

var cooldown : float = 1.0
var on_cooldown : bool = false

func enter_state(player_node):
	super(player_node)
	
	if(!on_cooldown):
		
		match player.get_node("attack_state").current_spell:
			"ice spears":
				ice_spears()
			
		
		start_cooldown()
	
	
	player.change_state("move_state")


func ice_spears():
	for i in 5:
		var icicle = load("res://Characters/Player/Scripts/StateMachine/mage_class/Attacks/icicle.tscn").instantiate()
		player.add_child(icicle)
		icicle.position += player.local_mouse_pos.normalized() * 15
		icicle.velocity = player.local_mouse_pos.normalized() * 10
		await get_tree().create_timer(0.1).timeout
	
	player.mana -= 20


##player is unable to use the spell again until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false


##player should lose a certain amount of health
func hit_response(source):
	$"../hurt_state".damage_hitbox = source
	player.change_state("hurt_state")

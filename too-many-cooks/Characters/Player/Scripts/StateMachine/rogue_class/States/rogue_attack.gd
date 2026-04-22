extends PlayerState

var cooldown : float = 0.3
var on_cooldown : bool = false

var equipped_status : String = "poison"
var active_status : String = ""

var mana_gain : float = 10

func enter_state(player_node):
	super(player_node)
	
	if(!on_cooldown):
		
		var attack = load("res://Characters/Player/Scripts/StateMachine/rogue_class/Attacks/throwing_knife.tscn").instantiate()
		
		#makes projectile a sibling of the player
		get_tree().get_root().add_child(attack)
		
		#sets projectile starting position to be a short distance away from the player in the direction they are aiming
		attack.global_position = player.global_position + player.local_mouse_pos.normalized() * 15
		attack.velocity = player.local_mouse_pos.normalized() * 5
		attack.look_at(player.global_mouse_pos)
		
		#connects hitbox to function that restores player's mana
		attack.get_node("Hitbox").connect("area_entered", on_attack_hit)
		
		attack.status = active_status
		
		await get_tree().create_timer(0.1).timeout
		
		start_cooldown()
	
	player.change_state("move_state")

##causes player's weapon sprite to swing downwards when attacking
func input_handler(delta : float) -> void:
	player.get_node("Weapon").rotation_degrees += 500 * player.current_x_dir * delta

##changes the player's equipped poison when scrolling the mouse wheel up or down
#scrolling up: poison -> slow -> weaken -> poison
#scrolling down: poison -> weaken -> slow -> poison
func switch_equipped():
	if(Input.is_action_just_pressed("scroll_up")):
		#print_debug("scrolled up")
		match equipped_status:
			"poison":
				equipped_status = "slow"
			"slow":
				equipped_status = "weaken"
			"weaken":
				equipped_status = "poison"
			_:
				equipped_status = "poison"
	
	if(Input.is_action_just_pressed("scroll_down")):
		#print_debug("scrolled down")
		match equipped_status:
			"poison":
				equipped_status = "weaken"
			"weaken":
				equipped_status = "slow"
			"slow":
				equipped_status = "poison"
			_:
				equipped_status = "poison"
	
	print_debug("equipped " + equipped_status)

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

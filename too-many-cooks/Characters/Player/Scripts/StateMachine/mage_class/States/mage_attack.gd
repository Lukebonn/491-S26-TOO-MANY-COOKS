extends PlayerState

var attack : PackedScene = load("res://Characters/Player/Scripts/StateMachine/mage_class/Attacks/mage_attack.tscn")

var power : float = 0.5

var cooldown : float = 0.2
var on_cooldown : bool = false

var mana_gain : float = 30

var current_spell : String = "ice spears"

##Calls player_state enter_state method to have 'player' reference player node
func enter_state(player_node):
	#print_debug("attack_state entered")
	super(player_node)
	
	if(!on_cooldown):
		
		var hitbox = attack.instantiate()
		hitbox.connect("body_entered", on_attack_hit)
		
		player.add_child(hitbox)
		hitbox.look_at(player.global_mouse_pos)
		
		player.set_damage(power)
		
		await get_tree().create_timer(0.1).timeout
		
		#player has their hitbox disabled
		
		hitbox.queue_free()
		
		switch_equipped()
		
		start_cooldown()
	
	player.change_state("move_state")

func input_handler(delta : float) -> void:
	player.get_node("Weapon").rotation_degrees += 500 * player.current_x_dir * delta

##player is unable to attack until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

##player regains mana when attacking enemies
#also plays a sound effect
func on_attack_hit(_body):
	player.play_sound(load("res://Audio/Sounds/Player/Mage/mage staff smack.mp3"))
	
	player.mana += mana_gain


##cycles to the next spell
#scroll up: ice spears -> fire blast -> vortex -> ice spears
#scroll down: ice spears -> vortex -> fire blast -> ice spears
func switch_equipped():
	#await get_tree().process_frame
	
	#player.get_node("SpellIndicator").cycle_up()
	#match current_spell:
	#	"ice spears":
	#		current_spell = "fire blast"
	#	"fire blast":
	#		current_spell = "vortex"
	#	"vortex":
	#		current_spell = "ice spears"
	#	_:
	#		current_spell = "ice spears"
	
	##cycles spell when mouse wheel scrolls up
	#ice spears -> fire blast -> vortex -> ice spears
	if(Input.is_action_just_pressed("scroll_up")):
		PlayerStats.icon_bar.cycle_left()
		match current_spell:
			"ice spears":
				current_spell = "fire blast"
			"fire blast":
				current_spell = "vortex"
			"vortex":
				current_spell = "ice spears"
			_:
				current_spell = "ice spears"
	
	##cycles spell when mouse wheel scrolls down
	#ice spears -> vortex -> fire blast -> ice spears
	if(Input.is_action_just_pressed("scroll_down")):
		PlayerStats.icon_bar.cycle_right()
		match current_spell:
			"ice spears":
				current_spell = "vortex"
			"vortex":
				current_spell = "fire blast"
			"fire blast":
				current_spell = "ice spears"
			_:
				current_spell = "ice spears"

##player should lose a certain amount of health
func hit_response(source):
	$"../hurt_state".damage_hitbox = source
	player.change_state("hurt_state")

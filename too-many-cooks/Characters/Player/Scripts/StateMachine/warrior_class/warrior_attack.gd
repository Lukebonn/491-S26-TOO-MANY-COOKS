extends PlayerState

var attack_1 : PackedScene = load("res://Characters/Player/Attacks/warrior/warrior_attack_1.tscn")
var duration_1 : float = 0.1

var attack_2 : PackedScene = load("res://Characters/Player/Attacks/warrior/warrior_attack_1.tscn")
var duration_2 : float = 0.1

var attack_3 : PackedScene = load("res://Characters/Player/Attacks/warrior/warrior_attack_3.tscn")
var duration_3 : float = 0.3

var cooldown : float = 0.2
var on_cooldown : bool = false

var combo_counter : int = 0
var combo_timer : Timer = Timer.new()
var first_time : bool = true

var mana_gain : float = 10

func enter_state(player_node):
	super(player_node)
	
	if(first_time):
		player.add_child(combo_timer)
		combo_timer.timeout.connect(reset_combo)
		
		first_time = false
	
	if(!on_cooldown):
		
		lunge_player()
		
		match combo_counter:
			0:
				await execute_attack(attack_1, duration_1)
				combo_counter = 1
			1:
				await execute_attack(attack_2, duration_2)
				combo_counter = 2
			2:
				await execute_attack(attack_3, duration_3)
				combo_counter = 0
			_:
				await execute_attack(attack_1, duration_1)
				
		#print_debug("Combo" + str(combo_counter))
		
		combo_timer.start(0.4)
		start_cooldown()
	
	player.change_state("move_state")

##intantiates attack scene, adds it to player scene, rotates it to look at mouse, then waits for a duration and removes it from the tree
#hitbox: attack scene to be instantiated
#duration: how long the attack should be active
func execute_attack(attack, duration):
	var hitbox = attack.instantiate()
	hitbox.connect("body_entered", on_attack_hit)
	
	player.add_child(hitbox)
	hitbox.look_at(player.global_mouse_pos)
	
	await get_tree().create_timer(duration).timeout
	
	hitbox.queue_free()

##makes the player do a short lunge forward when attacking
func lunge_player():
	player.velocity += player.local_mouse_pos.normalized() * 70
	
	await get_tree().create_timer(0.1).timeout
	
	player.velocity = Vector2(0,0)

##player is unable to attack until cooldown timer expires
func start_cooldown():
	on_cooldown = true
	
	await get_tree().create_timer(cooldown).timeout
	
	on_cooldown = false

func reset_combo():
	combo_counter = 0

##player regains mana when attacking enemies
func on_attack_hit(_body):
	player.mana += mana_gain

##player should lose a certain amount of health
func hit_response(source):
	$"../hurt_state".damage_hitbox = source
	player.change_state("hurt_state")

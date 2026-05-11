extends CharacterBody2D

var health : float = PlayerStats.MaxHealth + PlayerStats.passive_hp
var displayHealth : int = int(health)

var mana : float = PlayerStats.MaxMana + PlayerStats.passive_mana
# Dawson - not entirely sure if Mana needs to be a float since we'll
# likely just be using whole numbers for it.
var displayMana : int = int(mana)

##current stats including modifiers
#currently unused except for speed
var strength : int = PlayerStats.base_str + PlayerStats.passive_str
#var defense : int = PlayerStats.base_def + PlayerStats.passive_def
#var magic : int = PlayerStats.base_mag + PlayerStats.passive_mana
var speed : int = 12
var speed_mult : int = PlayerStats.base_spd + PlayerStats.passive_spd

var damage : int

var equipped_class : PlayerClass

var current_x_dir : int = 1

var current_dir : Vector2

var local_mouse_pos : Vector2
var global_mouse_pos : Vector2

var current_state : PlayerState

#Emitted when attempting to use Special, but no MP is available.
signal notEnoughMana()
#Emitted when the player has died.
signal playerDeath()
#Bool var for quick death state checking.
var dead : bool = false

var num_keys : int = 0
#Number of held Keys, used by Key and Lock objects.

#Emitted when death state gives off the signal to stop the combat music
signal Music_Stop()
##Called when the node enters the scene tree for the first time.
#player should be in idle state when loaded
#loads the correct class for the player
func _ready() -> void:
	#if %UI:
	#	print("hi")
	
	PlayerStats.player_ref = self
	
	match PlayerStats.current_class:
		PlayerStats.classes.none:
			equipped_class = load("res://System/Classes/blank_class.tres")
		PlayerStats.classes.warrior:
			equipped_class = load("res://System/Classes/warrior.tres")
		PlayerStats.classes.mage:
			equipped_class = load("res://System/Classes/mage.tres")
			#add_child(load("res://Characters/Player/Scripts/StateMachine/mage_class/SpecialUI/spell_indicator.tscn").instantiate())
			
			##adds a new state node to the player that is used for the mage's fire blast spell
			var fire_state = Node.new()
			add_child(fire_state)
			fire_state.name = "fire_state"
			fire_state.set_script(load("res://Characters/Player/Scripts/StateMachine/mage_class/States/fireball_state.gd"))
		PlayerStats.classes.rogue:
			equipped_class = load("res://System/Classes/rogue.tres")
		_:
			equipped_class = load("res://System/Classes/blank_class.tres")
	
	set_class(equipped_class)
	
	current_state = get_node("idle_state")
	current_state.enter_state(self)
	add_to_group("player")


##sets the states from the class resorce into the player state machine and applies stat modifiers
func set_class(new_class : PlayerClass):
	$dash_state.set_script(new_class.dash)
	$attack_state.set_script(new_class.attack)
	$magic_state.set_script(new_class.magic)
	
	#strength *= new_class.str_mod
	#defense *= new_class.def_mod
	#magic *= new_class.mag_mod
	
	$Weapon/Sprite2D.texture = new_class.weapon_sprite


##changes state to the node whose name matches new_state
#new_state: idle_state, move_state, dash_state, attack_state, magic_state (more to be added)
func change_state(new_state : String):
	if(current_state): #just in case current_state is null for some reason
		current_state.exit_state()
	
	current_state = get_node(new_state)
	current_state.enter_state(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#calls the input_handler function of current_state every frame
func _physics_process(delta: float) -> void:
	#print(position)
	local_mouse_pos = get_local_mouse_position()
	global_mouse_pos = get_global_mouse_position()
	
	current_dir = velocity.normalized()
	
	#player sprite faces left or right following the mouse
	if(local_mouse_pos.x < 0):
		current_x_dir = -1
		$Weapon/Sprite2D.flip_v = true
		$Sprite2D.flip_h = true
	elif(local_mouse_pos.x > 0):
		current_x_dir = 1
		$Weapon/Sprite2D.flip_v = false
		$Sprite2D.flip_h = false
	
	#hitbox is pointed towards the mouse unless the player is attacking
	if(current_state != get_node("attack_state")):
		$Weapon.look_at(global_mouse_pos)
	
	if(current_state):
		current_state.input_handler(delta)
	
	#when using the rogue or mage classes, player can use the mouse wheel to switch their equipped status effect or spell
	if((PlayerStats.current_class == PlayerStats.classes.rogue or PlayerStats.current_class == PlayerStats.classes.mage) and 
	(Input.is_action_just_pressed("scroll_up") or Input.is_action_just_pressed("scroll_down"))):
		$attack_state.switch_equipped()
	
	#when using the warrior class, if the player parries, the weapon will flip horizontally
	if(PlayerStats.current_class == PlayerStats.classes.warrior and Input.is_action_just_pressed("magic")):
		$Weapon/Sprite2D.flip_h = true
		await get_tree().create_timer(0.4).timeout
		$Weapon/Sprite2D.flip_h = false
	move_and_slide()


##triggers when a hitbox enters the player's hurtbox
func _on_hurtbox_area_entered(area):
	current_state.hit_response(area)


##caluclates how much damage the player does to the enemy
#multipler: a float representing how the strength of the player's attack
func set_damage(multiplier : float):
	damage = int(strength * multiplier)


##plays a sound effect from AudioStreamPlayer2D
func play_sound(sound : AudioStream):
	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()


func _on_death_state_combat_music_stop() -> void:
	Music_Stop.emit()

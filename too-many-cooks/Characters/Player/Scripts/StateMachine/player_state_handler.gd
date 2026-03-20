extends CharacterBody2D

var health : float = PlayerStats.MaxHealth
var displayHealth : int = int(health)

var mana : float = PlayerStats.MaxMana 
# Dawson - not entirely sure if Mana needs to be a float since we'll
# likely just be using whole numbers for it.
var displayMana : int = int(mana)

##current stats including modifiers
#currently unused except for speed
var strength : int = PlayerStats.base_str
var defense : int = PlayerStats.base_def
var magic : int = PlayerStats.base_mag
var speed : int = 100

var equipped_class : PlayerClass

var current_dir : Vector2 = Vector2(0,-1)

var local_mouse_pos : Vector2
var global_mouse_pos : Vector2

var current_state : PlayerState

signal notEnoughMana()
# Is emitted when a spell is used without having enough Mana.
signal playerDeath()
# I think this one might be emitted when the player dies, not sure.

var num_keys : int = 0
#Number of held Keys, used by Key and Lock objects.

##Called when the node enters the scene tree for the first time.
#player should be in idle state when loaded
#loads the correct class for the player
func _ready() -> void:
	
	match PlayerStats.current_class:
		PlayerStats.classes.none:
			equipped_class = load("res://System/Classes/blank_class.tres")
		PlayerStats.classes.warrior:
			equipped_class = load("res://System/Classes/warrior.tres")
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
	
	strength *= new_class.str_mod
	defense *= new_class.def_mod
	magic *= new_class.mag_mod

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
	
	local_mouse_pos = get_local_mouse_position()
	global_mouse_pos = get_global_mouse_position()
	
	#player sprite faces left or right following the mouse
	if(local_mouse_pos.x < 0):
		$Sprite2D.flip_h = true
	if(local_mouse_pos.x > 0):
		$Sprite2D.flip_h = false
	
	#hitbox is pointed towards the mouse unless the player is attacking
	if(current_state != get_node("attack_state")):
		pass
		#$Hitbox.look_at(get_global_mouse_position())
	
	if(current_state):
		current_state.input_handler(delta)
	
	if speed >= PlayerStats.Max_Speed:
		speed = speed / 2
	
	if speed >= PlayerStats.Speed_Slowdown:
		speed = PlayerStats.Speed_Slowdown
	move_and_slide()

##triggers when a hitbox enters the player's hurtbox
func _on_hurtbox_area_entered(area):
	current_state.hit_response(area)

##triggers when player melee hitbox collides with something
#func on_attack_hit():
#	$attack_state.on_attack_hit()

##this should be in a script for managing the entire combat scene, not here
func _on_tavern_return_area_entered(_area: Area2D):
	call_deferred("go_to_tavern")
	# takes the player back to the tavern
##same as _on_tavern_return_area_entered
func go_to_tavern():
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")


##I commented these out because the player won't be changing classes while the player scene is loaded

#func _on_knight_pressed():
#	equipped_class = "Knight"
#	print("Your class is now: " + equipped_class)


#func _on_mage_pressed():
#	equipped_class = "Mage"
#	print("Your class is now: " + equipped_class)


#func _on_ranger_pressed():
#	equipped_class = "Ranger"
#	print("Your class is now: " + equipped_class)

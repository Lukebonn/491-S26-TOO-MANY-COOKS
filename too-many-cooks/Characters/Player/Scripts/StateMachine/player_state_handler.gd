extends CharacterBody2D

var health : float = PlayerStats.MaxHealth
var displayHealth : int = int(health)
var mana : float = PlayerStats.MaxMana 
# Dawson - not entirely sure if Mana needs to be a float since we'll
# likely just be using whole numbers for it.
var displayMana : int = int(mana)
var speed : int = 100
var Class = "Default"
var current_dir : Vector2 = Vector2(0,-1)

var local_mouse_pos : Vector2

var current_state : PlayerState

signal notEnoughMana()
# Is emitted when a spell is used without having enough Mana.
signal playerDeath()
# I think this one might be emitted when the player dies, not sure.

# Called when the node enters the scene tree for the first time.
#player should be in idle state when loaded
func _ready() -> void:
	current_state = get_node("idle_state")
	current_state.enter_state(self)

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
	
	#player sprite faces left or right following the mouse
	if(local_mouse_pos.x < 0):
		$Sprite2D.flip_h = true
	if(local_mouse_pos.x > 0):
		$Sprite2D.flip_h = false
	
	#hitbox is pointed towards the mouse unless the player is attacking
	if(current_state != get_node("attack_state")):
		$Hitbox.look_at(get_global_mouse_position())
	
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
func _on_hitbox_area_entered(_area):
	$attack_state.on_attack_hit()


func _on_tavern_return_area_entered(area: Area2D):
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")
	# takes the player back to the tavern


func _on_knight_pressed():
	Class = "Knight"
	print("Your class is now: " + Class)


func _on_mage_pressed():
	Class = "Mage"
	print("Your class is now: " + Class)


func _on_ranger_pressed():
	Class = "Ranger"
	print("Your class is now: " + Class)

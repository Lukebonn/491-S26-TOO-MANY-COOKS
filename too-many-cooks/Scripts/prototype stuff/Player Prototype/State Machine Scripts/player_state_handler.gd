extends CharacterBody2D
var speed : int = 200
var current_dir : Vector2 = Vector2(0,-1)

var local_mouse_pos : Vector2

var current_state : PlayerState

# Called when the node enters the scene tree for the first time.
#player should be in idle state when loaded
func _ready() -> void:
	current_state = get_node("idle_state")
	current_state.enter_state(self)

##changes state to the node whose name matches new_state
#new_state: idle_state, move_state, dash_state, (more to be added)
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
		$Sprite2D.flip_h = false
	if(local_mouse_pos.x > 0):
		$Sprite2D.flip_h = true
	
	#hitbox is pointed towards the mouse unless the player is attacking
	if(current_state != get_node("attack_state")):
		$Hitbox.look_at(get_global_mouse_position())
	
	if(current_state):
		current_state.input_handler(delta)
	
	move_and_slide()
	

extends PlayerState

var dash_speed : int = 1000
var duration : float = 0.2

# Called when the node enters the scene tree for the first time.
func enter_state(player_node):
	print_debug("dash_state entered")
	super(player_node)
	
	player.velocity = Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down")) * dash_speed
	player.velocity = player.velocity.normalized() * dash_speed
	
	duration = 0.2


func input_handler(delta : float) -> void:
	if(duration > 0):
		duration -= delta
	else:
		player.change_state("move_state")

'''extends AudioStreamPlayer

const player_min_x: float = 500 #player spawn
const player_max_x: float = 600 #enemy slime
const zero_volume: int = -40

@export var Player: CharacterBody2D
@export var transition: float
var xmin: float
var xmax: float

# Called when the node enters the scene tree for the first time.
func _ready():
	set_transition(.1)

func set_transition(value: float):
	transition = value
	compute_x_bounds()
	

func compute_x_bounds():
	var d = player_max_x - player_min_x
	xmin = player_min_x + (d- d*transition) / 2.0
	xmax = player_min_x + (d- d*transition) / 2.0
	#update the volume between the two locations

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var px = Player.global_position.x #get player location on x axis
	var r = inverse_lerp(xmin, xmax, px) #gets it back as ratio in range
	
	#updates the volume
	stream.set_sync_stream_volume (0, min (zero_volume + r* (-zero_volume),0.0))
	
	stream.set_sync_stream_volume (0, min (zero_volume + (1.0 - r) * (-zero_volume),0.0))
'''

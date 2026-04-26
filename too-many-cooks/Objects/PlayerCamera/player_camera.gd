extends Camera2D
@export var Player : CharacterBody2D
#vars for camera shake
@export var decay: float = 0.8
@export var max_offset: Vector2 = Vector2(20, 20)
@export var max_roll: float = 0.1

var trauma: float = 0.0
var trauma_power: int = 10

#for if we want to move the camera away from the character sometimes 
#like to introduce a boss or something
var is_following_player = true
var sensitivity = 60
func _ready():
	randomize()
	add_to_group("camera")
	#if there is no player set try to make it a sibling
	if Player == null:
		Player = $"../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#TODO: make it so the camera is disjoint off the player slightly
	#based on the vector of the 
	
	
	if is_following_player:
		position = Player.position + get_mouse_vector()/sensitivity
	
	#this is for the camera shake functionality and is constantly checking if the camera shake functionality has been called
	if trauma: 
		trauma = max(trauma - decay * delta, 0)
		#shake()
		#the screenshake is so much lmao i commented out because
		#its so intense

func get_mouse_vector():
	var value = Player.position + get_local_mouse_position()
	return value

#function to be called outside if want screen shake
func add_trauma(amount: float) -> void:
	#capping the screen shake at one pretty much, so even if "amount" is greater than one it will cap at one
	trauma = min(trauma + amount, 1.0)

func shake() -> void:
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1,1)
	offset.x = max_offset.x * amount * randf_range(-1,1)
	offset.y = max_offset.y * amount * randf_range(-1,1)

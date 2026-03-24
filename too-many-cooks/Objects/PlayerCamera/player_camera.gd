extends Camera2D
@export var Player : CharacterBody2D

#for if we want to move the camera away from the character sometimes 
#like to introduce a boss or something
var is_following_player = true
var sensitivity = 60
func _ready():
	#if there is no player set try to make it a sibling
	if Player == null:
		Player = $"../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#TODO: make it so the camera is disjoint off the player slightly
	#based on the vector of the 
	
	
	if is_following_player:
		position = Player.position + get_mouse_vector()/sensitivity

func get_mouse_vector():
	var value = Player.position + get_local_mouse_position()
	return value

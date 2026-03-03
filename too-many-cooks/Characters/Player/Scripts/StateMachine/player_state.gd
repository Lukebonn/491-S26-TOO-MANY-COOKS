class_name PlayerState
extends Node

#holds the player node
var player

##code that should execute when entering state
func enter_state(player_node):
	player = player_node

##code that should execute when exiting state
func exit_state():
	pass

##defines player behaviors in each state, is called each frame by handler script
func input_handler(_delta : float) -> void:
	pass

##code that should execute when the player gets hit
#source: the node that causes the damage
func hit_response(source):
	pass

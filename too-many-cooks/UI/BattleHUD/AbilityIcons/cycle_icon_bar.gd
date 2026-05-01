extends Control

var current : Texture
var left : Texture
var right : Texture

func _ready():
	current = $Current/Icon.texture
	left = $Left/Icon.texture
	right = $Right/Icon.texture

func _input(_event):
	if(Input.is_action_just_pressed("scroll_down")):
		#cycles the textures to the left
		$Current/Icon.texture = left
		$Right/Icon.texture = current
		$Left/Icon.texture = right
		
		#reassigns the variables to their new values
		var temp = current
		
		current = left
		left = right
		right = temp
		
		
	elif(Input.is_action_just_pressed("scroll_up")):
		#cycles the textures to the right
		$Current/Icon.texture = right
		$Right/Icon.texture = left
		$Left/Icon.texture = current
		
		#reassigns the variables to their new values
		var temp = current
		
		current = right
		right = left
		left = temp
		

extends Control

var current : Texture
var left : Texture
var right : Texture

func _ready():
	PlayerStats.icon_bar = self
	
	current = $HBoxContainer/MagicIcons/Current/Icon.texture
	left = $HBoxContainer/MagicIcons/Left/Icon.texture
	right = $HBoxContainer/MagicIcons/Right/Icon.texture

##cycles the textures to the left
func cycle_left():
	$HBoxContainer/MagicIcons/Current/Icon.texture = left
	$HBoxContainer/MagicIcons/Right/Icon.texture = current
	$HBoxContainer/MagicIcons/Left/Icon.texture = right
	
	#reassigns the variables to their new values
	var temp = current
	
	current = left
	left = right
	right = temp

##cycles the textures to the right
func cycle_right():
	$HBoxContainer/MagicIcons/Current/Icon.texture = right
	$HBoxContainer/MagicIcons/Right/Icon.texture = left
	$HBoxContainer/MagicIcons/Left/Icon.texture = current
	
	#reassigns the variables to their new values
	var temp = current
	
	current = right
	right = left
	left = temp

extends Control

var current : Texture
var left : Texture
var right : Texture
@export var mpCost : Array[int]
var mpCost_indx : int = 0

func _ready():
	PlayerStats.icon_bar = self
	
	$Label.text = str(mpCost[mpCost_indx]) + "mp"
	
	current = $HBoxContainer/MagicIcons/Current/Icon.texture
	left = $HBoxContainer/MagicIcons/Left/Icon.texture
	right = $HBoxContainer/MagicIcons/Right/Icon.texture

##cycles the textures to the left
func cycle_left():
	$HBoxContainer/MagicIcons/Current/Icon.texture = left
	$HBoxContainer/MagicIcons/Right/Icon.texture = current
	$HBoxContainer/MagicIcons/Left/Icon.texture = right
	
	
	#increases index by one, unless it equals 2, in which cast it is reset to 0
	if(mpCost_indx == 0):
		mpCost_indx = 2
	else:
		mpCost_indx -= 1
	
	#changes the text of the mpCost label
	$Label.text = str(mpCost[mpCost_indx]) + "mp"
	
	
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
	
	
	#increases index by one, unless it equals 2, in which cast it is reset to 0
	if(mpCost_indx == 2):
		mpCost_indx = 0
	else:
		mpCost_indx += 1
	
	#changes the text of the mpCost label
	$Label.text = str(mpCost[mpCost_indx]) + "mp"
	
	
	#reassigns the variables to their new values
	var temp = current
	
	current = right
	right = left
	left = temp

extends Control

var current : Texture
var left : Texture
var right : Texture

@export var poison_frame : Texture
@export var slow_frame : Texture
@export var weaken_frame : Texture
@export var mpCost : Array[int]

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


##changes the frame of the attack icon to match the color of the currently applied debuff
func set_frame(debuff : String):
	match debuff:
		"poison":
			$HBoxContainer/AttackIcon/Frame.texture = poison_frame
		"slow":
			$HBoxContainer/AttackIcon/Frame.texture = slow_frame
		"weaken":
			$HBoxContainer/AttackIcon/Frame.texture = weaken_frame
		_:
			$HBoxContainer/AttackIcon/Frame.texture = poison_frame

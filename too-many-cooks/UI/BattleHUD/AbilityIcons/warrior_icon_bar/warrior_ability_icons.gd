extends Control

@export var parry_icon : Texture
@export var throw_icon : Texture
@export var spin_icon : Texture
@export var mpCost : Array[int]

##sets global variable to self
func _ready():
	PlayerStats.icon_bar = self
	$Label.text = "20mp"

##sets the current and right ability icons according to the player's current combo counter
func set_icons(counter : int):
	$Label.text = str(mpCost[counter]) + "mp"
	match counter:
		0:
			$HBoxContainer/MagicIcons/Current/Icon.texture = parry_icon
			$HBoxContainer/MagicIcons/Right/Icon.texture = throw_icon
		1:
			$HBoxContainer/MagicIcons/Current/Icon.texture = throw_icon
			$HBoxContainer/MagicIcons/Right/Icon.texture = spin_icon
		2:
			$HBoxContainer/MagicIcons/Current/Icon.texture = spin_icon
			$HBoxContainer/MagicIcons/Right/Icon.texture = parry_icon
		_:
			$HBoxContainer/MagicIcons/Current/Icon.texture = parry_icon
			$HBoxContainer/MagicIcons/Right/Icon.texture = throw_icon

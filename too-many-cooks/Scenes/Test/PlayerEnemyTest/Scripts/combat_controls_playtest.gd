extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerStats.Magic != "Fireball":
		$ControlsNoRanged.show()
	else:
		$ControlsHasRanged.show()

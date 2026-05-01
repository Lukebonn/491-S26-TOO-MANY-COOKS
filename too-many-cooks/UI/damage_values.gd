extends Label

@export var damage_type: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match damage_type:
		"Player":
			text = str(PlayerStats.Enemy_Damage_Dealt)
		"Enemy":
			text = str(PlayerStats.Player_Damage_Dealt)

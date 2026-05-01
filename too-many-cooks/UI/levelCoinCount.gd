extends Label
@export var counter : String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match counter:
		"Gold":
			text = str(PlayerStats.Floor_Gold)
		"Orbs":
			text = str(PlayerStats.Floor_Orbs)
		"Enemies":
			text = str(PlayerStats.Enemies_Defeated)

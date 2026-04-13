extends RichTextLabel
@export var counter : String


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match counter:
		"Gold":
			text = str(PlayerStats.Gold)
		"Orbs":
			text = str(PlayerStats.Orbs)
	# just keeps track of the gold count. Nothing too fancy.

extends RichTextLabel



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = str(PlayerStats.Orbs)
	# just keeps track of the gold count. Nothing too fancy.

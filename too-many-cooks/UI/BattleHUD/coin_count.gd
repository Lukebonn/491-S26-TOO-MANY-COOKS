extends RichTextLabel



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(PlayerStats.Gold)
	# just keeps track of the gold count. Nothing too fancy.

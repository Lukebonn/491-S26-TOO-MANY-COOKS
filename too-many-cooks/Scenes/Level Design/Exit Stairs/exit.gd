extends Area2D
signal current_mana
signal current_health


func _on_body_entered(body):
	if body.name == "Player":
		LevelQueue.load_level()
		current_health.emit()
		current_mana.emit()

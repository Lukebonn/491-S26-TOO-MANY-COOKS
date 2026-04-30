extends Area2D
signal current_mana
signal current_health
signal level_complete

## should going in this exit do anything? (ie unlock act #2 or something)
@export var Unlock_Act : String

func _on_body_entered(body):
	if body.name == "Player":
		if Unlock_Act:
			match Unlock_Act:
				"act2":
					Global.Act_2_Unlocked = true
				"act3":
					Global.Act_3_Unlocked = true
		#LevelQueue.load_level()
		level_complete.emit()
		current_health.emit()
		current_mana.emit()

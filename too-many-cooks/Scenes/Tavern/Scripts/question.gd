extends Button
@export var dialogue_ref : Control
@export var hoverSound : AudioStreamPlayer
@export var clickSound : AudioStreamPlayer
func _ready():
	self.connect("pressed",_on_pressed)

func _on_pressed():
	#clickSound.play()
	match text:
		"\"I lost. Badly.\"":
			dialogue_ref.show_dialogue("Warrior","7,8,16,17,18,19,20,21,22,23","0,0")
		"\"I almost had it.\"":
			dialogue_ref.show_dialogue("Warrior","10,11,16,17,18,19,20,21,22,23","0,0")
		"\"I don't want to go back.\"":
			dialogue_ref.show_dialogue("Warrior","13,14,16,17,18,19,20,21,22,23","0,0")
	
		"\"I'll help the tavern.\"":
			dialogue_ref.show_dialogue("Warrior","25,26,34,35","0,0")
		"\"What's happening at the tavern?\"":
			dialogue_ref.show_dialogue("Warrior","28,29,34,35","0,0")
		"\"Does it really matter?\"":
			dialogue_ref.show_dialogue("Warrior","31,32,34,35","0,0")
	
		"\"I don't feel like a warrior.\"":
			dialogue_ref.show_dialogue("Warrior","37,38,46,47,48,49,50","0,0")
		"\"I want to get stronger.\"":
			dialogue_ref.show_dialogue("Warrior","40,41,46,47,48,49,50","0,0")
		"\"I'm not sure I can do this again.\"":
			dialogue_ref.show_dialogue("Warrior","43,44,46,47,48,49,50","0,0")
		
		"\"I'll help fix this place.\"":
			dialogue_ref.show_dialogue("Warrior","52,58,59,60,61,62,63,64,65","0,0")
		"\"This place suits you.\"":
			dialogue_ref.show_dialogue("Warrior","54,58,59,60,61,62,63,64,65","0,0")
		"\"You live down here?\"":
			dialogue_ref.show_dialogue("Warrior","56,58,59,60,61,62,63,64,65","0,0")
		
		"\"Why keep writing?\"":
			dialogue_ref.show_dialogue("Warrior","67,73,74,75,76,77","0,0")
		"\"What do you tell them?\"":
			dialogue_ref.show_dialogue("Warrior","69,73,74,75,76,77","0,0")
		"\"You should go back someday.\"":
			dialogue_ref.show_dialogue("Warrior","71,73,74,75,76,77","0,0")
		


	get_parent().hide_menu()
	dialogue_ref.is_awaiting_response = false


#func _on_mouse_entered() -> void:
	#hoverSound.play()

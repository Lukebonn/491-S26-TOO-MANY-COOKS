extends Control
#MOVE THE CONTAINER NOT THE CONTROL OR THE DIALOGUE!!!!
#offscreen = Contianer (576,1000)
#onscreen = Container (576,700)

var is_printing_text = false
var is_awaiting_response = false
@export var text_speed = .02

#args character = which character are we talking to? pulled from a JSON list prolly
#args index = which bit of dialogue are we pulling from? characters will have multiple diff things to say

func show_dialogue(character: String, index: String):
	$"..".in_dialogue = true
	var tween = get_tree().create_tween()
	tween.tween_property($Container,"position",Vector2($Container.position.x,700),.5).set_trans(Tween.TRANS_CUBIC)
	print_text(character, index)
	
func hide_dialogue():
	var tween = get_tree().create_tween()
	tween.tween_property($Container,"position",Vector2($Container.position.x,1000),.5).set_trans(Tween.TRANS_CUBIC)
	$"..".in_dialogue = false

func print_text(character: String, index: String):
	$Container/Speaker/SpeakerLabel.text = character
	
	is_printing_text = true
	var message_ref = find_message(character, index)
	
	#check if its string (one line) or array (more than one)
	if message_ref is String:
		print(message_ref)
		$Container/Dialogue/DialogueLabel.text = message_ref
		$Container/Dialogue/DialogueLabel.visible_characters = 0
		for letter in message_ref.length():
			$Container/Dialogue/DialogueLabel.visible_characters += 1 
			await get_tree().create_timer(text_speed).timeout
		await $"..".next_line
		hide_dialogue()
	else:
		for line in message_ref:
			$Container/Dialogue/DialogueLabel.visible_characters = 0
			print(line)
			$Container/Dialogue/DialogueLabel.text = line
			for letter in line.length():
				$Container/Dialogue/DialogueLabel.visible_characters += 1 
				await get_tree().create_timer(text_speed).timeout
			await $"..".next_line
		hide_dialogue()
	
		#$Container/Dialogue/DialogueLabel.text = line
	#find the text we want from loaded dictionary of text in our game
	#then print it out
	#we also want to be able to encode things like expressions
	#and sounds

func find_message(character: String, index: String):
	match character:
		"Meowy":
			match index:
				"default":
					return ["I'm saying this", "And this."]
				"other":
					return "Sometimes I do this."
		"KingArthur":
			match index:
				"scolding":
					return "I'm so mad about that thing that happened!"
	

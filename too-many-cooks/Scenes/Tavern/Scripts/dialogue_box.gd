extends Control
#MOVE THE CONTAINER NOT THE CONTROL OR THE DIALOGUE!!!!
#offscreen = Contianer (576,1000)
#onscreen = Container (576,700)

var is_printing_text = false
var is_awaiting_response = false

var in_dialogue = false

@export var text_speed = .01

signal next_line
signal message_complete

#args character = which character are we talking to? pulled from a JSON list prolly
#args index = which bit of dialogue are we pulling from? characters will have multiple diff things to say

func _input(event):
	if event is InputEventMouseButton:
		next_line.emit()

func show_dialogue(character: String, index, emotions):
	in_dialogue = true
	var tween = get_tree().create_tween()
	tween.tween_property($Container,"position",Vector2($Container.position.x,700),.5).set_trans(Tween.TRANS_CUBIC)
	print_text(character, index, emotions)
	
func hide_dialogue():
	var tween = get_tree().create_tween()
	tween.tween_property($Container,"position",Vector2($Container.position.x,1000),.5).set_trans(Tween.TRANS_CUBIC)
	in_dialogue = false
	message_complete.emit()
	

func print_text(character: String, index, emotions):
	#`var emote
	$Container/Speaker/SpeakerLabel.text = character
	is_printing_text = true
	Global.Is_In_Dialogue = true
	var message_ref = find_message(character, index, emotions)
	
	#check if its string (one line) or array (more than one)
	if message_ref is String:
		$Container/Dialogue/DialogueLabel.text = message_ref
		$Container/Dialogue/DialogueLabel.visible_characters = 0
		for letter in message_ref.length():
			$Container/Dialogue/DialogueLabel.visible_characters += 1 
			await get_tree().create_timer(text_speed).timeout
		await next_line
		hide_dialogue()
	else:
		for line in message_ref:
			var emote = find_emote(character, emotions, line)
			$Container/Dialogue/DialogueLabel.visible_characters = 0
			$Container/Dialogue/DialogueLabel.text = line.right(-3)
			for letter in line.length():
				$Container/Dialogue/DialogueLabel.visible_characters += 1 
				await get_tree().create_timer(text_speed).timeout
			await next_line
		hide_dialogue()
		$Container/SpeakerSprite.hide()
	Global.Is_In_Dialogue = false
	
#Find the emotions of the NPC based on a tag with the following patter [X]
#0 = Base Emote, 1 = Happy/Smiling, 2 = Sad/Frown, 3 = Mad, 4 = Surprised
func find_emote(character: String, emotions, line: String):
	#print(line + "test")
	$Container/SpeakerSprite.show()
	var tag = line[1]
	match tag:
		"0":
			$Container/SpeakerSprite.texture = emotions[0]
			print("I'm just here") 
		"1":
			$Container/SpeakerSprite.texture = emotions[1]
			print("I'm so happy") 
		"2": 
			$Container/SpeakerSprite.texture = emotions[2] 
			print("I'm so sad")
		"3": 
			$Container/SpeakerSprite.texture = emotions[3]
			print("Grr, I'm mad")
		"4": 
			$Container/SpeakerSprite.texture = emotions[4]
			print("Woah, I'm surprised")
	
		#$Container/Dialogue/DialogueLabel.text = line
	#find the text we want from loaded dictionary of text in our game
	#then print it out
	#we also want to be able to encode things like expressions
	#and sounds
	
#func find_options(character: String, line: String):
	#var tag = line[1]
	#if tag == "b":
		#$Container/Dialogue/DialogueOption1.show()
		#$Container/Dialogue/DialogueOption2.show()
		#match line[2]:
			#"1":
				#$Container/Dialogue/DialogueOption1.text
			#"2":
				#$Container/Dialogue/DialogueOption1.text


func find_message(character: String, index, emotions):
	var text : Array[String]
	var file
	
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
		"ChattyCatty":
			match index:
				pass
		"Tutorial":
			file = FileAccess.open("res://Scenes/Tavern/NPCs/NPC1.txt", FileAccess.READ)
				
		
		"Playtest":
			file = FileAccess.open("res://Scenes/Tavern/NPCs/PLAYTEST.txt", FileAccess.READ)
			Global.Has_Finished_Playtest = true
		"Gramps":
			file = FileAccess.open("res://Scenes/Tavern/NPCs/INTRO.txt", FileAccess.READ)
		"Warrior":
			file = FileAccess.open("res://Scenes/Tavern/NPCs/WARRIOR.txt", FileAccess.READ)
		"Rogue":
			file = FileAccess.open("res://Scenes/Tavern/NPCs/RANGER.txt", FileAccess.READ)
		"Mage":
			file = FileAccess.open("res://Scenes/Tavern/NPCs/MAGE.txt",FileAccess.READ)
	var body = file.get_as_text()
	body = body.split("\n")
	index = index.split(",")
	for line in index:
		print(body.get(line.to_int()))
		text.append(body.get(line.to_int()))
	return text

extends Control
#MOVE THE CONTAINER NOT THE CONTROL OR THE DIALOGUE!!!!
#offscreen = Contianer (576,1000)
#onscreen = Container (576,700)

var is_printing_text = false
var is_awaiting_response = false

var in_dialogue = false
var await_question = false
var end_of_dialogue = false

@export var text_speed = .01

signal next_line
signal message_complete
signal show_question(questions : Array)
signal done_printing

@export var GrampsPortraits: Array[Texture]
@export var WarriorPortraits: Array[Texture]
@export var MagePortraits: Array[Texture]
@export var RoguePortraits: Array[Texture]


#args character = which character are we talking to? pulled from a JSON list prolly
#args index = which bit of dialogue are we pulling from? characters will have multiple diff things to say

func _input(event):
	if Input.is_action_just_pressed("attack"):
		if in_dialogue:
			text_speed = 0
			print("skipping")
		if !is_awaiting_response:
			next_line.emit()


func show_dialogue(character: String, index, emotions):
	in_dialogue = true
	end_of_dialogue = false
	var tween = get_tree().create_tween()
	#var portrait_tween = get_tree().create_tween()
	tween.tween_property($Container,"position",Vector2($Container.position.x,700),.5).set_trans(Tween.TRANS_CUBIC)
	#portrait_tween.tween_property($Container/SpeakerSprite,"position",Vector2($Container/SpeakerSprite.position.x,700),.5).set_trans(Tween.TRANS_CUBIC)
	#print($Container.global_position)
	#print($Container/SpeakerSprite.global_position)
	
	print_text(character, index, emotions)
	
func end_dialogue():
	var tween = get_tree().create_tween()
	#var portrait_tween = get_tree().create_tween()
	tween.tween_property($Container,"position",Vector2($Container.position.x,2000),.5).set_trans(Tween.TRANS_CUBIC)
	in_dialogue = false
	Global.Is_In_Dialogue = false
	message_complete.emit()
	

func print_text(character: String, index, emotions):
	#`var emote
	$Container/Speaker/SpeakerLabel.text = character
	is_printing_text = true
	Global.Is_In_Dialogue = true
	var message_ref = find_message(character, index, emotions)
	
	#check if its string (one line) or array (more than one)
	if message_ref is String:
		text_speed = .01
		$Container/Dialogue/DialogueLabel.text = message_ref
		$Container/Dialogue/DialogueLabel.visible_characters = 0
		for letter in message_ref.length():
			$Container/Dialogue/DialogueLabel.visible_characters += 1 
			if text_speed != 0:
				await get_tree().create_timer(text_speed).timeout
		await next_line
		if end_of_dialogue:
			end_dialogue()
	else:
		for line in message_ref:
			text_speed = .01
			if line.contains("/"):
				is_awaiting_response = true
				var split_line = line.split("/")
				line = split_line[0]
				var questions_array = split_line[1]
				show_question.emit(questions_array)
			if line.contains("#"):
				end_of_dialogue = true
				line = line.replace("#","")
			find_portrait(character, index, emotions, line)
			$Container/Dialogue/DialogueLabel.visible_characters = 0
			$Container/Dialogue/DialogueLabel.text = line.right(-3)
			
			for letter in line.length():
				$Container/Dialogue/DialogueLabel.visible_characters += 1 
				if text_speed != 0:
					await get_tree().create_timer(text_speed).timeout
			done_printing.emit()
			is_printing_text = false
			await next_line
		if end_of_dialogue:
			end_dialogue()
			var portrait_tween = get_tree().create_tween()
			#$Container/SpeakerSprite.hide()

func find_message(character: String, index, emotions):
	var text : Array[String]
	var file
	match character:
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
		"Player":
			file = FileAccess.open("res://Scenes/Tavern/NPCs/PLAYER.txt",FileAccess.READ)
		"Narrator":
			file = FileAccess.open("res://Scenes/Tavern/NPCs/NARRATOR.txt",FileAccess.READ)
	var body = file.get_as_text()
	body = body.split("\n")
	index = index.split(",")
	for line in index:
		print(body.get(line.to_int()))
		text.append(body.get(line.to_int()))
	return text

#Will read to find the correct character speaker and then look for the tag
# that will load the correct emotion. The portraits will get direct references
#0 = No Emote/Keeps previous emote, 1 = Happy/Smiling, 2 = Sad/Frown, 3 = Mad, 4 = Surprised 5 = Neutral
func find_portrait(character: String, index, emotions, line: String):
	var tag = line[1]
	$Container/SpeakerSprite.show()
	match character:
		"Gramps":
			match tag:
				"0":
					pass
					#$Container/SpeakerSprite.texture = $Gramps.emotions[0]
				"1":
					$Container/SpeakerSprite.texture = GrampsPortraits[0]
					print("Gramps so happy") 
				"2": 
					$Container/SpeakerSprite.texture = GrampsPortraits[1] 
					print("Gramps so sad")
				"3": 
					$Container/SpeakerSprite.texture = GrampsPortraits[2]
					print("Grr, Gramps mad")
				"4": 
					$Container/SpeakerSprite.texture = GrampsPortraits[3]
					print("Woah, Gramps surprised")
				"5":
					$Container/SpeakerSprite.texture = GrampsPortraits[4]
					print("Gramps just here") 
		"Warrior":
			match tag:
				"0":
					pass
					#$Container/SpeakerSprite.texture = $Warrior.emotions[0]
				"1":
					$Container/SpeakerSprite.texture = WarriorPortraits[0]
					print("Warrior so happy") 
				"2": 
					$Container/SpeakerSprite.texture = WarriorPortraits[1] 
					print("Warrior so sad")
				"3": 
					$Container/SpeakerSprite.texture = WarriorPortraits[2]
					print("Grr, Warrior mad")
				"4": 
					$Container/SpeakerSprite.texture = WarriorPortraits[3]
					print("Woah, Warrior surprised")
				"5":
					$Container/SpeakerSprite.texture = WarriorPortraits[4]
					print("Warrior just here")
		"Rogue":
			match tag:
				"0":
					pass
					#$Container/SpeakerSprite.texture = $Rogue.emotions[0]
				"1":
					$Container/SpeakerSprite.texture = RoguePortraits[0]
					print("Rogue so happy") 
				"2": 
					$Container/SpeakerSprite.texture = RoguePortraits[1] 
					print("Rogue so sad")
				"3": 
					$Container/SpeakerSprite.texture = RoguePortraits[2]
					print("Grr, Rogue mad")
				"4": 
					$Container/SpeakerSprite.texture = RoguePortraits[3]
					print("Woah, Rogue surprised")
				"5":
					$Container/SpeakerSprite.texture = RoguePortraits[4]
					print("Rogue just here")
		"Mage":
			match tag:
				"0":
					pass
					#$Container/SpeakerSprite.texture = $Mage.emotions[0]
				"1":
					$Container/SpeakerSprite.texture = MagePortraits[0]
					print("Mage so happy") 
				"2": 
					$Container/SpeakerSprite.texture = MagePortraits[1] 
					print("Mage so sad")
				"3": 
					$Container/SpeakerSprite.texture = MagePortraits[2]
					print("Grr, Mage mad")
				"4": 
					$Container/SpeakerSprite.texture = MagePortraits[3]
					print("Woah, Mage surprised")
				"5":
					$Container/SpeakerSprite.texture = MagePortraits[4]
					print("Mage just here")

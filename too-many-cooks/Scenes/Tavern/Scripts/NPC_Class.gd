class_name NPC extends TextureButton

@onready var DialogueBox = $"../../../Dialogue Box"
@export var Name : String
@export var Expressions : Array[Texture]
@export var Conversations : Array[String]
@export var Times_Spoken_With : int
@export var clickSound : AudioStreamPlayer
@export var hoverSound : AudioStreamPlayer
@export var bond_rank : int
var selected = -1
var conversation: int = 0
func _ready():
	self.connect("pressed",_send_conversation,0)
	self.connect("mouse_entered",_on_mouse_entered)
	self.connect("mouse_exited",_on_mouse_exited)
	self.modulate = Color(.5,.5,.5)
	reset_bond_rank()
func _send_conversation():
	reset_bond_rank()
	#some day we find a way to get the conversation we want
	#maybe variant takes from ur current spell,
	#or the npc's current relation with you (a new variable)
	#or a boss thats been defeated
	#clickSound.play()
	if !Global.Is_In_Dialogue:
		if selected != -1:
			DialogueBox.show_dialogue(Name,Conversations[selected], Expressions)
		elif Times_Spoken_With == 0:
			if Global.Act_3_Unlocked:
				DialogueBox.show_dialogue(Name,Conversations[2], Expressions)
			if Global.Act_2_Unlocked:
				DialogueBox.show_dialogue(Name,Conversations[1], Expressions)
			else:
				DialogueBox.show_dialogue(Name,Conversations[0], Expressions)
		elif Times_Spoken_With != 0:
			if Name != "Gramps":
				match bond_rank:
					0:
						var random = randi_range(6,10)
						DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
					1:
						var random = randi_range(11,15)
						DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
					2:
						var random = randi_range(11,15)
						DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
					3:
						var random = randi_range(16,20)
						DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
					4:
						var random = randi_range(16,20)
						DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
					5:
						var random = randi_range(21,25)
						DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
			else:
				if Global.Act_3_Unlocked:
					var random = randi_range(16,21)
					DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
				if Global.Act_2_Unlocked:
					var random = randi_range(11,15)
					DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
				else:
					var random = randi_range(6,10)
					DialogueBox.show_dialogue(Name,Conversations[random], Expressions)
		Times_Spoken_With += 1


func _on_mouse_entered():
	self.modulate = Color(1,1,1)
	#hoverSound.play()
func _on_mouse_exited():
	self.modulate = Color(.5,.5,.5)
	
func reset_bond_rank():
	match Name:
		"Warrior":
			bond_rank = PlayerStats.MeleeClassAbilityLevel
		"Rogue":
			bond_rank = PlayerStats.RogueClassAbilityLevel
		"Mage":
			bond_rank = PlayerStats.MageClassAbilityLevel

class_name NPC extends TextureButton

@onready var DialogueBox = $"../../../Dialogue Box"
@export var Name : String
@export var Expressions : Array[Texture]
@export var Conversations : Array[String]
@export var Times_Spoken_With : int
@export var clickSound : AudioStreamPlayer
@export var hoverSound : AudioStreamPlayer
var selected = -1
var conversation: int = 0
func _ready():
	self.connect("pressed",_send_conversation,0)
	self.connect("mouse_entered",_on_mouse_entered)
	self.connect("mouse_exited",_on_mouse_exited)
	self.modulate = Color(.5,.5,.5)
func _send_conversation():
	#some day we find a way to get the conversation we want
	#maybe variant takes from ur current spell,
	#or the npc's current relation with you (a new variable)
	#or a boss thats been defeated
	#clickSound.play()
	if !Global.Is_In_Dialogue:
		if selected != -1:
			DialogueBox.show_dialogue(Name,Conversations[selected], Expressions)
		elif Times_Spoken_With == 0:
			DialogueBox.show_dialogue(Name,Conversations[0], Expressions)
		else:
			DialogueBox.show_dialogue(Name,Conversations[1], Expressions)
		Times_Spoken_With += 1


func _on_mouse_entered():
	self.modulate = Color(1,1,1)
	#hoverSound.play()
func _on_mouse_exited():
	self.modulate = Color(.5,.5,.5)

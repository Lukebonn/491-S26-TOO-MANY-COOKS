class_name NPC extends TextureButton

@onready var DialogueBox = $"../../Dialogue Box"
@export var Name : String
@export var Expressions : Array[Texture]
@export var Conversations : Array[String]

func _ready():
	self.connect("pressed",_send_conversation)
	

func _send_conversation():
	#some day we find a way to get the conversation we want
	#maybe variant takes from ur current spell,
	#or the npc's current relation with you (a new variable)
	#or a boss thats been defeated
	DialogueBox.show_dialogue("NPC1",Conversations[0])

	

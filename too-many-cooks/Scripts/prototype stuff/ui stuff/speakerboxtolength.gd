extends Panel
@export var child_dialogue = RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	size.x = child_dialogue.size.x + 20

extends Panel
@export var child_dialogue = RichTextLabel
# Called when the node enters the scene tree for the first time.
func _process(delta):
	size.x = child_dialogue.text.length()*25

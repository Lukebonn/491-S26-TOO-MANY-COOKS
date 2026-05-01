extends HBoxContainer

##The portrait image to use for this person.
@export var Portrait : Texture
##The name of this person, first and last.
@export var Name : String
##The contributor title for this person. "LEAD PROGRAMMER", etc.
@export var Title : String

func _ready() -> void:
	$TextureRect.texture = Portrait
	$VBoxContainer/Name.text = Name
	$VBoxContainer/Title.text = Title

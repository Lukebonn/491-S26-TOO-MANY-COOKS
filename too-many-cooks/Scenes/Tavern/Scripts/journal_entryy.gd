class_name journal_entry extends Button

@export var Author : String
@export var Body : String
@export var journal_text_ref : RichTextLabel
@export var journal_author_ref : RichTextLabel
@export var journal_panel_ref : Panel
@export var clickSound : AudioStreamPlayer
@export var hoverSound : AudioStreamPlayer

func _ready():
	self.connect("pressed",_on_pressed)
	clickSound = $"ButtonClickSound"
	hoverSound = $"ButtonHoverSound"

	
func _on_pressed():
	print(journal_text_ref)
	journal_text_ref.text = "\t" + Body
	journal_author_ref.text = Author
	journal_panel_ref.show_menu()
	clickSound.play()

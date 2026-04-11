class_name journal_entry extends Button

@export var Author : String
@export var Body : String
@export var journal_text_ref : RichTextLabel
@export var journal_panel_ref : Panel

func _ready():
	self.connect("pressed",_on_pressed)
	journal_text_ref 
	journal_panel_ref = $"../../../../../JournalPanel"

	
func _on_pressed():
	print(journal_text_ref)
	journal_text_ref.text = Body
	journal_panel_ref.show_menu()

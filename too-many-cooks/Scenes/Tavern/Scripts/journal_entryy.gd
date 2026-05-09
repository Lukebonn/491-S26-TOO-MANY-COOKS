class_name journal_entry extends Button

@export var Locked : bool
@export var Title : String
@export var Unlock_Goal : int
@export var Author : String
@export var Body : String
@export var journal_text_ref : RichTextLabel
@export var journal_author_ref : RichTextLabel
@export var journal_panel_ref : Panel
@export var clickSound : AudioStreamPlayer
@export var hoverSound : AudioStreamPlayer

func _ready():
	check_avaliablilty()
	self.connect("pressed",_on_pressed)
	#clickSound = $"ButtonClickSound"
	#hoverSound = $"ButtonHoverSound"

func check_avaliablilty():
	match Author:
		"Akari":
			if Unlock_Goal <= PlayerStats.MeleeClassAbilityLevel:
				disabled = false
				text = Title
			else:
				text = "Requires Melee Ability Class Level " + str(Unlock_Goal)
				disabled = true
		"Renly":
			if Unlock_Goal <= PlayerStats.RogueClassAbilityLevel:
				disabled = false
				text = Title
			else:
				text = "Requires Rogue Ability Class Level " + str(Unlock_Goal)
				disabled = true
		"Walter":
			if Unlock_Goal <= PlayerStats.MageClassAbilityLevel:
				disabled = false
				text = Title
			else:
				text = "Requires Mage Ability Class Level " + str(Unlock_Goal)
				disabled = true
	
func _on_pressed():
	print(journal_text_ref)
	journal_text_ref.text = "\t" + Body
	journal_author_ref.text = Author + " "
	journal_panel_ref.show_menu()

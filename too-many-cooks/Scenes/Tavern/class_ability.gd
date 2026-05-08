extends HBoxContainer

##Which Ability this is. 0 for Attack, 1 for Dash, 2 onwards for Spells.
@export var ID : int
##The ability level needed to show this Ability's upgraded text.
@export var LevelUp: int
##Description for the unupgraded version for this Ability.
##0 is Warrior, 1 is Mage, and 2 is Rogue.
@export var Text : Array[String]
##Description for the upgraded version for this Ability.
##0 is Warrior, 1 is Mage, and 2 is Rogue.
@export var UpgradedText : Array[String]
##Images for this Ability.
##0 is Warrior, 1 is Mage, and 2 is Rogue.
@export var Img : Array[Texture]

#ID for current Class, which array index to use. 0 for Warrior, etc.
var class_id : int = 0
#Prefix to add to text description, based on class_id.
var prefix : String

func _ready() -> void:
	match ID:
		0:
			prefix = "Attack - "
		1:
			prefix = "Dash - "
		2:
			prefix = "Spell 1 - "
		3:
			prefix = "Spell 2 - "
		4:
			prefix = "Spell 3 - "
		5:
			prefix = "Spell 4 - "

func init_update(id: int, lv: int):
	class_id = id
	$Img.texture = Img[class_id]
	update_data(lv)

func update_data(lv: int):
	if lv >= LevelUp:
		$Txt.text = UpgradedText[class_id]
	else:
		$Txt.text = Text[class_id]

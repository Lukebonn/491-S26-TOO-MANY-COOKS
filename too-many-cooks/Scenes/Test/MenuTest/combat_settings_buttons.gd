extends VBoxContainer
#slop script

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.First_Time_Tavern:
		$TavernButton.hide()

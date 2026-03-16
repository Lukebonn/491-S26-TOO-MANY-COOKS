extends StaticBody2D

func _ready():
	$ChestOpened.visible = false 
	$ChestClosed.visible = true

func _on_key_chest_opened():
	$ChestOpened.visible = true
	$ChestClosed.visible = false

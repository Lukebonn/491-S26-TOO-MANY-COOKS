extends Node2D
@export var dialogue_ref : Control
func _ready():
	FadeInFadeOut.fade_in()
	if Global.First_Time_Tavern:
		dialogue_ref.show_dialogue("Intro","2,3","0,0")
		await dialogue_ref.message_complete
		$FirstTimeUI.show()


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.

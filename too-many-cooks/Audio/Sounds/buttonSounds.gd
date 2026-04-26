extends Button

@export var hoverSound : AudioStreamPlayer
@export var clickSound : AudioStreamPlayer

func _on_mouse_entered() -> void:
	if hoverSound:
		hoverSound.play()

func _on_button_down() -> void:
	if clickSound:
		clickSound.play()

func continue_enable():
	
	if SaveMgr.GameData != null:
		Button.disabled = false

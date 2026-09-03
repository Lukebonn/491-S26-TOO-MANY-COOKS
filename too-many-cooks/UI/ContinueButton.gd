extends Button

@export var hoverSound : AudioStreamPlayer
@export var clickSound : AudioStreamPlayer

func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("button_down", _on_button_down)
	if not Global.New_Game:
		text = "Continue"

func _on_mouse_entered() -> void:
	if hoverSound:
		hoverSound.play()

func _on_button_down() -> void:
	if clickSound:
		clickSound.play()

#func continue_enable():
	#if SaveMgr.GameData != null:
		#Button.disabled = false

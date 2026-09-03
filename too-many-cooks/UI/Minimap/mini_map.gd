extends Node2D


func _ready() -> void:
	Global.connect("disableMinimap", _on_disable_minimap)
	if not Global.minimapEnabled:
		$MiniMap.visible = false

func _on_disable_minimap() -> void:
	print("hi")
	if Global.minimapEnabled:
		$MiniMap.visible = true
	else:
		$MiniMap.visible = false

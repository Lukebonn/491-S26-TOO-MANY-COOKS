extends Sprite2D

#Reference to TavernBG node.
var ref : Control

func _ready() -> void:
	ref = $"../../../Tavern BG"

func _process(_delta: float) -> void:
	if ref:
		var pos = ref.position.abs().x / 2304
		pos = pos * 288
		position = Vector2(pos, 8.0)

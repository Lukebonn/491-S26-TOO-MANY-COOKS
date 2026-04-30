extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation = "Close"
	frame = 0
	if $"../ObjRoomMgr":
		$"../ObjRoomMgr".connect("close_barriers", _on_close_barriers)
		$"../ObjRoomMgr".connect("open_barriers", _on_open_barriers)


func _on_close_barriers() -> void:
	play("Close")


func _on_open_barriers() -> void:
	play("Open")

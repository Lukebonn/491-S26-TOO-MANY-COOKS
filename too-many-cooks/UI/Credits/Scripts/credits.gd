extends VBoxContainer

##The y position to tween to. May have to experiment for precise, good-looking value.
@export var TweenTarget : float = 0.0
##The time spent tweening the Credits UI.
@export var TweenTime : float = 10.0

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(0,TweenTarget),TweenTime).set_trans(Tween.TRANS_LINEAR)

extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		var tween = get_tree().create_tween()
		tween.tween_property($cover,"position",Vector2(-1152,0),0.1).set_trans(Tween.TRANS_EXPO)
		tween.tween_property($background,"position",$Marker2D.position,0.2).set_trans(Tween.TRANS_EXPO)
		for sprite in $buttons.get_children():
			tween.tween_property(sprite, "position", Vector2($Marker2D.position.x-160,sprite.position.y), 0.05).set_trans(Tween.TRANS_EXPO)
	if Input.is_action_pressed("ui_right"):
		var tween = get_tree().create_tween()
		for sprite in $buttons.get_children():
			tween.tween_property(sprite, "position", Vector2($Marker2D.position.x+160,sprite.position.y), 0.02).set_trans(Tween.TRANS_EXPO)
		tween.tween_property($background,"position",$Marker2D2.position,0.1).set_trans(Tween.TRANS_EXPO)
		tween.tween_property($cover,"position",Vector2(0,0),0.1).set_trans(Tween.TRANS_EXPO)

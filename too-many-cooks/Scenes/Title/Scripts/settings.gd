extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	do_settings_action("show_menu")

func do_settings_action(action: String):
	match action:
		"show_menu":
			var tween = get_tree().create_tween()
			print(tween)
			tween.tween_property($cover,"position",Vector2(-1152,0),0.1).set_trans(Tween.TRANS_EXPO)
			tween.tween_property($background,"position",$Marker2D.position,0.2).set_trans(Tween.TRANS_EXPO)
			for sprite in $buttons.get_children():
				tween.tween_property(sprite, "position", Vector2($Marker2D.position.x-160,sprite.position.y), 0.05).set_trans(Tween.TRANS_EXPO)
		"hide_menu":
			var tween = get_tree().create_tween()
			for sprite in $buttons.get_children():
				tween.tween_property(sprite, "position", Vector2($Marker2D.position.x+160,sprite.position.y), 0.02).set_trans(Tween.TRANS_EXPO)
			tween.tween_property($background,"position",$Marker2D2.position,0.1).set_trans(Tween.TRANS_EXPO)
			tween.tween_property($cover,"position",Vector2(0,0),0.1).set_trans(Tween.TRANS_EXPO)
		

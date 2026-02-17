extends Camera3D

@export var menu_camera_spot : Marker3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_title_ui_stop_spinning_enivonment():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self,"position",menu_camera_spot.global_position,1.0).set_trans(Tween.TRANS_EXPO)
	tween.parallel().tween_property(self,"rotation",menu_camera_spot.rotation,1.0).set_trans(Tween.TRANS_EXPO)

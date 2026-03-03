extends Node3D
@export var speed : float
var current_speed = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"current_speed",speed,3.0).set_trans(Tween.TRANS_LINEAR)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	spin(delta)

func spin(delta):
	self.rotate_y(current_speed*delta)


func _on_title_ui_stop_spinning_enivonment():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"current_speed",0.0,1.0).set_trans(Tween.TRANS_LINEAR)

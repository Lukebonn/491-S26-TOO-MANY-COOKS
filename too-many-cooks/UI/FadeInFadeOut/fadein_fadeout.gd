extends Control
@export var FileLocation : String
@export var start_faded : bool
#simple drag and drop solution for fades

signal fade_complete

func _init():
	if start_faded:
		$ColorRect.color = Color(.1,.1,.1,1)

func fade_out():
	mouse_filter = Control.MOUSE_FILTER_STOP
	$ColorRect.color = Color(0,0,0,0)
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect,"color",Color(.1,.1,.1,1),1)
	fade_complete.emit()
	
func fade_in():
	$ColorRect.color = Color(.1,.1,.1,1)
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect,"color",Color(0,0,0,0),1)
	

extends Node
@export var Number : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = str(Number)
	go_up()

func go_up():
	var tween = create_tween()
	var x = randf_range(-10, 10)
	var y = randf_range(-5, -15)
	tween.set_parallel(true)
	tween.tween_property(self,"position",Vector2(x,y),.25).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self,"modulate",Color(1,1,1,0),.65).set_trans(Tween.TRANS_CUBIC)
func _on_timer_timeout():
	queue_free()

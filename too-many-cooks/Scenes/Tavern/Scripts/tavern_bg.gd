extends Control

var direction = 0
@export var scroll_speed = 300.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"..".in_dialogue == false:
		position.x = position.x + (direction * scroll_speed * delta)
		position.x = clamp(position.x,-2304.0,0.0)

func _on_left_panel_mouse_entered():
	#lerp it to -1
	var tween = get_tree().create_tween()
	tween.tween_property(self,"direction",10,1).set_trans(Tween.TRANS_CUBIC)


func _on_right_panel_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"direction",-10,1).set_trans(Tween.TRANS_CUBIC)


func _either_panel_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"direction",0,1).set_trans(Tween.TRANS_CUBIC)


func _on_chatty_catty_pressed():
	$"../Dialogue Box".show_dialogue("Meowy","default")
	#we wont do this method for everything probably
	#but we also need a way to tell the dialogue box what to say
	#a simple method is giving "show_dialogue" an argument that is the text we need
	#but that method falls short if we want our fellas to say unique things thru a run
	#(which we do)


func _on_door_andy_pressed():
	print("leaving...")
	get_tree().change_scene_to_file("res://Scenes/enemy_test.tscn")


func _on_guy_3_pressed():
	$"../Dialogue Box".show_dialogue("KingArthur","scolding")

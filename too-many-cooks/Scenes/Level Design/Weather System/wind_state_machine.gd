extends Node

@export var debug : bool = true

var state : State = null:
	set(value):
		if state != null:
			state.exit()
		
		state = value
		state.enter()

func _input(event):
	if event is InputEventKey and debug:
		if event.pressed and event.keycode == KEY_1:
			state = Breeze.new(get_tree())
		
		if event.pressed and event.keycode == KEY_2:
			state = HeavyWind.new(get_tree())
		
		if event.pressed and event.keycode == KEY_3:
			state = NoWind.new(get_tree())

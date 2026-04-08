extends Node

var target

var potency : int

var duration : float

func _ready():
	await get_tree().create_timer(duration).timeout
	queue_free()

func _process(delta):
	target.health -= potency * delta

#thing.add_child(load("res://poison.gd"))

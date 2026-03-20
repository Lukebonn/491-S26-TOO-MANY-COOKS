extends "res://Scenes/Level Design/Weather System/WindStates.gd"
class_name  Breeze

var scene_tree: SceneTree

func _init(tree):
	scene_tree = tree
	
func enter():
	for object in scene_tree.get_nodes_in_group("Sway"):
		object.material = load("res://Scenes/Level Design/Weather System/Breeze.tres")

func exit():
	for object in scene_tree.get_nodes_in_group("Sway"):
		object.material = null

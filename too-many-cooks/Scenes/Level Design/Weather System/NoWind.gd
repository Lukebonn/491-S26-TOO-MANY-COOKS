extends "res://Scenes/Level Design/Weather System/WindStates.gd"
class_name NoWind

var scene_tree: SceneTree

func _init(tree):
	scene_tree = tree

func enter():
	for object in scene_tree.get_nodes_in_group("Sway"):
		object.material = null

func exit():
	pass

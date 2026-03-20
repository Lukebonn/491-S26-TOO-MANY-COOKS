extends "res://Scenes/Level Design/Weather System/FogState.gd"
class_name NoFog

var layer: ColorRect

func _init (color_rect):
	layer = color_rect
	
func enter():
	layer.color = Color (1,1,1,0)
	layer.material = null	

func exit():
	pass

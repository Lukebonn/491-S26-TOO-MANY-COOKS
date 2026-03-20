extends "res://Scenes/Level Design/Weather System/FogState.gd"
class_name Fog

var layer: ColorRect

func _init(color_rect):
	layer = color_rect	

func enter():
	layer.color = Color(1,1,1,1)
	layer.material = load("res://Scenes/Level Design/Weather System/Fog.tres")
	
func exit():
	layer.material = null
	layer.color = Color(1,1,1,0) #set to transpararent

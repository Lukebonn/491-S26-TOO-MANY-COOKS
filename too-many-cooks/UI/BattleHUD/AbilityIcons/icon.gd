extends Control

@export var icon_texture : Texture

func _ready():
	$Icon.texture = icon_texture

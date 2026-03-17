extends Node2D
signal on_chest_opened

var opened = false
#Whether or not this chest is open.
var animRef : AnimationPlayer
#Ref to AnimationPlayer.
var spriteRef : Sprite2D
#Ref to Sprite2D.

func _ready() -> void:
	animRef = $AnimationPlayer
	spriteRef = $Sprite2D

func open_chest():
	opened = true
	animRef.play("open")
	on_chest_opened.emit()

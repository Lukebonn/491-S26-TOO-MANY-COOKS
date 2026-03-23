extends Node2D

var is_open = false
#Whether or not this door is open, and thus enterable.
var animRef : AnimationPlayer
#Ref to AnimationPlayer.
var spriteRef : Sprite2D
#Ref to Sprite2D.
##Whether or not this Door should start already open.
@export var StartOpen = false

func _ready() -> void:
	animRef = $AnimationPlayer
	spriteRef = $Sprite2D
	is_open = StartOpen
	if is_open:
		spriteRef.frame = 3
	else:
		spriteRef.frame = 0

func set_open(open: bool):
	is_open = open
	if is_open:
		animRef.play("open")
	else:
		animRef.play("close")

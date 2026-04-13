extends Node2D

var is_open = false
#Whether or not this door is open, and thus enterable.
var is_locked = false
#Whether this door has been locked (usually changed by an outside scene)
var animRef : AnimationPlayer
#Ref to AnimationPlayer.
var spriteRef : Sprite2D
#Ref to Sprite2D.
var camera
#needs to get the camera for camera shake
##Whether or not this Door should start already open.
@export var StartOpen = false

@onready var door_closing: AudioStreamPlayer2D = $doorClosing
@onready var door_opening: AudioStreamPlayer2D = $doorOpening
@onready var door_unlocking: AudioStreamPlayer2D = $doorUnlocking


func _ready() -> void:
	animRef = $AnimationPlayer
	spriteRef = $Sprite2D
	is_open = StartOpen
	camera = get_tree().get_first_node_in_group("camera")
	if is_open:
		spriteRef.frame = 3
	else:
		spriteRef.frame = 0

func set_open(open: bool):
	if is_locked:
		return
	if is_open == open:
		return
	is_open = open
	if is_open:
		animRef.play("open")
		door_opening.play()
	else:
		animRef.play("close")
		door_closing.play()

func set_locked(locked: bool):
	is_locked = locked
	door_unlocking.play()
	if camera:
		camera.add_trauma(0.5)
	
	if is_locked:
		$CollisionShape2D.set_deferred("disabled", false)
		set_open(false)
	else:
		$CollisionShape2D.set_deferred("disabled", true)
		set_open(true)

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("door opened")
	if body.name == "Player":
		set_open(true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("door closed")
	if body.name == "Player":
		set_open(false)

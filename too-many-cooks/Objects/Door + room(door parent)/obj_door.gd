extends Node2D

var is_open = false
#Whether or not this door is open, and thus enterable.
var is_locked = false
#Whether this door has been locked (usually changed by an outside scene)
var animRef : AnimationPlayer
#Ref to AnimationPlayer.
var spriteRef : Sprite2D
var spriteRef2 : Sprite2D
#Ref to Sprite2D.
var camera
#to check whether or not this door is attached to a room or attached to a lock
var is_key_lock_door: bool = false
#needs to get the camera for camera shake
##Whether or not this Door should start already open.
@export var StartOpen = false

@onready var door_closing: AudioStreamPlayer2D = $doorClosing
@onready var door_opening: AudioStreamPlayer2D = $doorOpening
@onready var door_unlocking: AudioStreamPlayer2D = $doorUnlocking



func _ready() -> void:
	add_to_group("door")
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	animRef = $AnimationPlayer
	spriteRef = $Sprite2D
	spriteRef2 = $Sprite2D2
	is_open = StartOpen
	for child in get_children():
		if child.is_in_group("lock"):
			is_key_lock_door = true
			child.on_unlock.connect(_on_child_lock_unlocked)
			set_locked(true)
			break
	camera = get_tree().get_first_node_in_group("camera")
	if is_open:
		spriteRef.frame = 3
		spriteRef2.frame = 3
	else:
		spriteRef.frame = 0
		spriteRef2.frame = 0

func set_open(open: bool):
	if is_locked or is_open == open  or EnemyStats.enemies_in_room > 0 and open == true:
		return
	is_open = open
	if is_open:
		animRef.play("open")
		door_opening.play()
	else:
		animRef.play("close")
		door_closing.play()

func set_locked(locked: bool):
	print("locking all doors")
	is_locked = locked
	door_unlocking.play()
	if camera:
		camera.add_trauma(0.5)
	
	if is_locked:
		print("locked")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		set_open(false)
		spriteRef.frame = 0
		spriteRef2.frame = 0
	else:
		print("unlocked")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		set_open(true)
		spriteRef.frame = 3
		spriteRef2.frame = 3

func get_locked() -> bool:
	return is_locked

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("door opened")
	if body.name == "Player":
		set_open(true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("door closed")
	if body.name == "Player":
		set_open(false)

#on the chance that this door is not a child of a room, but instead a parent of alock this will
#connect tehe signal of the lock unlocking to this door instance in the scene and unlock the door
func _on_child_lock_unlocked() -> void:
	print("Door received unlock signal from child from inserting a key")
	set_locked(false)

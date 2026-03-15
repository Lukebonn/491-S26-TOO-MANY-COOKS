extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $rotationNode/AnimatedSprite2D
@onready var rotation_node: Node2D = $rotationNode
@onready var arrow_start_marker: Marker2D = $rotationNode/arrowStartMarker

const ARROW = preload("uid://ccknvsbk3xdax")

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const ATTACK_COOLDOWN = 2.0

var cooldownCompleted = true
var isShooting = false
var inRange = false
var playerNode = null


func _physics_process(delta: float) -> void:
	if playerNode:
		_shoot()
	else:
		animated_sprite_2d.play("Idle")
	_set_animation()
	

func _shoot():
	isShooting = true
	animated_sprite_2d.play("Attack")
	cooldownCompleted = false

func _set_animation():	
	if not playerNode: 
		
		return
	
	var playerPosition = playerNode.global_position
	var direction = global_position.direction_to(playerPosition)
	
	if direction.x > 0:
		rotation_node.scale.x = 1
	elif direction.x < 0:
		rotation_node.scale.x = -1

func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation == "Attack":
		if animated_sprite_2d.frame == 5:
			_create_arrow()
			#implement later when animation frames don't do the job anymore for a cooldown
			#await get_tree().create_timer(0.5).timeout
			#cooldownCompleted = true
			
func _create_arrow():
	var arrowNode = ARROW.instantiate()
	
	arrowNode.direction = global_position.direction_to(playerNode.global_position)
	
	get_tree().current_scene.add_child(arrowNode)
	arrowNode.global_position = arrow_start_marker.global_position


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "Attack":
		isShooting = false
	animated_sprite_2d.play("Idle")

func _on_sight_area_entered(body: Area2D) -> void:
	print(body.name)
	if body.name == "Hurtbox":
		playerNode = body
		inRange = true
	#playerNode = body


func _on_sight_area_exited(body: Area2D) -> void:
	if body.name == "Hurtbox":
		playerNode = null
		inRange = false
		animated_sprite_2d.play("Idle")

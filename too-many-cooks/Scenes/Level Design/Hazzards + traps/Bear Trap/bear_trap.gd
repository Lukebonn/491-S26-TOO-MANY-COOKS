extends Area2D
class_name BearTrap

@export var trap_duration := 2.0

@onready var trap_sprite = $AnimatedSprite2D
@onready var trap_timer = $Timer
@onready var trap_collision = $CollisionShape2D

var trapped_player = null
var is_trapping := false


func _ready():
	trap_timer.wait_time = trap_duration


func _on_body_entered(body: CharacterBody2D) -> void:
	if trapped_player != null:
		return
	
	if body.is_in_group("player"):
		trapped_player = body
		activate_trap()
		print("Caught in a bear trap!")


func activate_trap():
	is_trapping = true
		# Play trap animation
	if trap_sprite:
		trap_sprite.play("snap")
		# Start timer
	trap_timer.start()


func _physics_process(delta):
	if is_trapping and trapped_player:
	# Force player to stop moving every frame
		trapped_player.velocity = Vector2.ZERO
				# Block all movement inputs every frame
		Input.action_release("move_up")
		Input.action_release("move_down")
		Input.action_release("move_left")
		Input.action_release("move_right")
		Input.action_release("dash")
		Input.action_release("attack")
		Input.action_release("magic")


func _on_timer_timeout():
	# Stop trapping
	is_trapping = false
	trapped_player = null
	
	# Disable trap so it can't trigger again
	if trap_collision:
		trap_collision.disabled = true

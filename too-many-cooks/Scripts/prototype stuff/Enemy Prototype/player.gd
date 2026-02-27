extends CharacterBody2D

const SPEED = 300

var current_dir = "none"
var last_direction: Vector2 = Vector2.RIGHT

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#Just a temp varaiable for now to showcase the player taking damage
var health = 100


	
func _physics_process(_delta: float) -> void:
		
	move_and_slide()
	process_animation()
	process_movement()
	#if Input.is_action_pressed("right"):
		#current_dir="right"
		#velocity.x=speed
		#velocity.y=0
	#elif Input.is_action_pressed("left"):
		#current_dir="left"
		#velocity.x=-speed
		#velocity.y=0
	#elif Input.is_action_pressed("up"):
		#current_dir="up"
		#velocity.x=0
		#velocity.y=-speed
	#elif Input.is_action_pressed("down"):
		#current_dir="down"
		#velocity.x=0
		#velocity.y=speed	
	#else:
		#velocity.x=0
		#velocity.y=0
		
func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else: 
		velocity = Vector2.ZERO

func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("walk", last_direction)
	else:
		play_animation("idle", last_direction)

func play_animation(prefix: String, dir: Vector2) -> void: 
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_side")
	if dir.y < 0:
		animated_sprite_2d.play(prefix + "_back")
	if dir.y > 0:
		animated_sprite_2d.play(prefix + "_front")

#The function for taking damage
func take_damage(amount):
	health -= amount
	print("Player took damage! Health: ", health)

#Upon entering an enemy, this should signal the player to take damage
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.has_method("get_damage"):
		take_damage(area.get_damage())
	print("damage!")

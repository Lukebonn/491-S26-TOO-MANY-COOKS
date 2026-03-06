extends Area2D

var velocity = Vector2.ZERO
var range = 100.0
var speed = 100.0
const KNOCKBACK_FORCE: int = 20
var player_chase=false
var player = null

var target = null
var start_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = global_position
	
func set_direction(direction: Vector2, player_level: int):
	# leaving this here to add the possibility of increasing 
	# damage/speed of projectile depending on level of the enemy
	speed += 20
	range += 10
	velocity = direction.normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += velocity * delta
	if global_position.distance_to(start_position) > range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "SwordEnemy"):
		body.take_damage(20,player.position)
	else:
		
		
#The function that gives the damage to the player
func get_damage():
	pass
	#return damage
	
	var speed = 300
	
func _ready():
	set_as_top_level(true)
	
func _process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation)*delta
	


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

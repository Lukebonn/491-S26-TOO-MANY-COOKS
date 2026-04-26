class_name Pickup extends CharacterBody2D
#most movement logic changes from pickup to pickup
#so go to their respective _pickup.gd to check em out
#code here is usually overwritten by new functions that better sell the vibe of the pickupp

##the name of the pickup, just for formalities sake
@export var Name : String
##how much the thing is worth of its resource (ex 1 vs 5 on a yellow or blue coin)
@export var Value : int
var target 
var weight = 0

func _ready():
	$Area2D.connect("body_entered",collect)
	$sight.connect("body_entered",nav_to_player)

func _process(delta):
	position += velocity
	if target:
		position = position.lerp(target.position, weight)
		weight += delta

func spawn_velocity():
	var random_vector = Vector2(randf_range(-1,1),randi_range(-1,-3))
	return random_vector

func collect(body):
	if body.name == "Player":
		print("Collected a " + Name)
		queue_free()

func nav_to_player(body):
	if body.name == "Player":
		target = body

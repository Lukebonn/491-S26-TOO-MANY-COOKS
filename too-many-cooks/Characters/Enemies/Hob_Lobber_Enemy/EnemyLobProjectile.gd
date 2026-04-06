extends Area2D

var speed = 100
var direction: Vector2
var playerLocation: Vector2

#makes it so we can call the poison effect on the player through the UI
##might be important to note that I'm pretty sure this is not the correct path
#@onready var status_manager = get_node("../UI")

@export var damage = 10
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var velocity: Vector2
var landed: bool = false
@export var projectile_gravity: float = 500.0
@export var launch_speed: float = 200.0


func _ready():
	add_to_group("enemy_projectile")
	set_as_top_level(true)
	$CollisionShape2D.set_deferred("disabled", true)
	
	##currently not adding launch_speed and instead using the speed dictated by projectile state that instantiated this projectile object
	var result = calculate_arc(global_position, playerLocation, projectile_gravity, launch_speed)
	velocity = result.velocity
	var flight_time = result.time
	#velocity.y -= 300
	
	get_tree().create_timer(flight_time).timeout.connect(_land)
	
func calculate_arc(start: Vector2, target: Vector2, gravity: float, arc_speed: float) -> Dictionary:
	var to_target = target - start
	#horizontal distance
	var dx = to_target.x
	#vertical distance
	var dy = to_target.y
	#(larger arc_speed = flatter arc)
	var t = abs(dx) / arc_speed
	
	if t == 0:
		return { "velocity": Vector2.ZERO, "time": 0.0 }
	
	var vx = dx / t
	var vy = (dy + 0.5 * gravity * t * t) / t
	
	return {
		"velocity": Vector2(vx,vy),
		"time": t
		}
	
func _process(delta: float) -> void:
	if landed:
		return #stop all motion and gravity and whatever else is causing the lob to be moving
	velocity.y += projectile_gravity * delta
	global_position += velocity * delta
	look_at(global_position + velocity)
		
#what this function is doing is 1. hiding the "potion" sprite
#2. turns on the collisions for the collision shape, so that it will send info to the player to be poisoned
#3. playing the poison animation roughly showing where you'll take damage while standing in it
#3. 
func _land() -> void:
	landed = true
	$Sprite2D.hide()
	$CollisionShape2D.set_deferred("disabled", false)
	velocity = Vector2(0,0)
	animated_sprite_2d.play("sphere")

#this is turned on after EnemyStats.airtime_of_lob_thrown_by_hob_lobber, 
#and used to tell the player it's been hit
func _on_area_entered(area: Area2D) -> void:
	if(area.name == "Hurtbox"):
		print("Player Poisoned From Hob Lobber's AoE!")
		#this will be used at one point after testing phase is over to slowly hurt the player
		#status_manager.applyStatusEffect.emit("Poison", 5)
		#check if status_manager is hooked correctly by uncommenting:
		#print(status_manager)

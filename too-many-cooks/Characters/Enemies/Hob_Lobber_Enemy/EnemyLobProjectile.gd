extends Area2D

var speed = 100
var direction: Vector2
var playerLocation: Vector2

#makes it so we can call the poison effect on the player through the UI.gd script
@onready var status_manager = get_node("../UI")

@export var damage = 10
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var velocity: Vector2
@export var projectile_gravity: float = 500.0
@export var launch_speed: float = 350.0


func _ready():
	add_to_group("enemy_projectile")
	set_as_top_level(true)
	$CollisionShape2D.set_deferred("disabled", true)
	
	velocity = direction * launch_speed
	velocity.y -= 300
	
	get_tree().create_timer(EnemyStats.airtime_of_lob_thrown_by_hob_lobber).timeout.connect(_land)
	
func _process(delta: float) -> void:
	velocity.y += projectile_gravity * delta
	global_position += velocity * delta
	look_at(global_position + velocity)
		
#what this function is doing is 1. hiding the "potion" sprite
#2. turns on the collisions for the collision shape, so that it will send info to the player to be poisoned
#3. playing the poison animation roughly showing where you'll take damage while standing in it
#3. 
func _land() -> void:
	$Sprite2D.hide()
	$CollisionShape2D.set_deferred("disabled", false)
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

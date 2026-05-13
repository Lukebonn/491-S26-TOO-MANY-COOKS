extends Area2D

var speed = 100
var direction: Vector2
var playerLocation: Vector2

#makes it so we can call the poison effect on the player through the UI
##might be important to note that I'm pretty sure this is not the correct path


@export var damage = 10
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var poison_scene = preload("res://Characters/Enemies/HobLobber/EnemyPoison.tscn")

var velocity: Vector2
var landed: bool = false
@export var projectile_gravity: float = 500.0
@export var launch_speed: float = 200.0


func _ready():
	animated_sprite_2d.hide()
	add_to_group("enemy_projectile")
	set_as_top_level(true)
	$Hitbox.set_deferred("disabled", true)
	
func _process(delta: float) -> void:
	if direction:
		global_position += direction * speed * delta
		look_at(global_position + direction)
		get_tree().create_timer(0.25, false).timeout.connect(_land)
		
#what this function is doing is 1. hiding the "potion" sprite
#2. turns on the collisions for the collision shape, so that it will send info to the player to be poisoned
#3. playing the poison animation roughly showing where you'll take damage while standing in it
#3. 
func _land() -> void:
	landed = true
	$Sprite2D.hide()
	animated_sprite_2d.show()
	speed=0
	$Hitbox.set_deferred("disabled", false)
	velocity = Vector2(0,0)
	animated_sprite_2d.play("sphere")
	##after landing it should last ____ seconds before dissappearing
	get_tree().create_timer(2.0, false).timeout.connect(queue_free)

#this is turned on after EnemyStats.airtime_of_lob_thrown_by_hob_lobber, 
#and used to tell the player it's been hit
func _on_area_entered(area: Area2D) -> void:
	if(area.name == "Hurtbox"):
		var player = area.get_parent() 
		print("Player Poisoned From Hob Lobber's AoE!")
		var poison_instance = poison_scene.instantiate()
		player.add_child(poison_instance)
		
		

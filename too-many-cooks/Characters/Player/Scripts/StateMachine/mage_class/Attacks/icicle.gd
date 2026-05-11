extends RigidBody2D

var velocity : Vector2

var damage : int

func _ready():
	damage = int((PlayerStats.base_str + PlayerStats.passive_str) * 1.3)

func _physics_process(_delta):
	move_and_collide(velocity)

##code that should execute when the projectile hits an enemy
#projectile despawns when hitting an enemy
#if ability is upgraded, instantiates an aoe attack on where it hits
func _on_hitbox_area_entered(_area):
	if(PlayerStats.MageClassAbilityLevel >= 1):
		var aoe = load("res://Characters/Player/Scripts/StateMachine/mage_class/Attacks/icicle_aoe.tscn").instantiate()
		get_tree().get_root().add_child(aoe)
		aoe.global_position = global_position
	queue_free()

##projectile should disappear when it hits a wall
func _on_hitbox_body_entered(_body: Node2D) -> void:
	queue_free()

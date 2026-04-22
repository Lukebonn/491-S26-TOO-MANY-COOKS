extends RigidBody2D

var velocity : Vector2

var damage : int

var status : String

func _ready() -> void:
	damage = int((PlayerStats.base_str + PlayerStats.passive_str))

func _physics_process(_delta):
	move_and_collide(velocity)

##projectile will add a status effect to the enemy and then delete itself when hitting an enemy
func _on_hitbox_area_entered(area: Area2D) -> void:
	if(status and area.get_parent() is Enemy and !area.get_parent().has_node(status)):
		print_debug("status applied")
		var new_status = load_status().instantiate()
		new_status.target = area.get_parent()
		area.get_parent().add_child(new_status)
	
	queue_free()

##projectile will delete itself when colliding with a wall or other collision object
func _on_hitbox_body_entered(_body: Node2D) -> void:
	queue_free()

##returns the scene to be added to the enemy as a child
func load_status() -> PackedScene:
	match status:
		"poison":
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/poison.tscn")
		"slow":
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/slow.tscn")
		"weaken":
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/weaken.tscn")
		_:
			return null

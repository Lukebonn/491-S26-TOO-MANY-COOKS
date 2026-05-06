extends RigidBody2D

var velocity : Vector2

var damage : int

var status : String

var buff_player : bool = false

var buff : String

func _ready() -> void:
	damage = PlayerStats.player_ref.strength


func _physics_process(_delta):
	move_and_collide(velocity)


##projectile will add a status effect to the enemy and then delete itself when hitting an enemy
#refreshes status if the enemy already has the equipped status on them
func _on_hitbox_area_entered(area: Area2D) -> void:
	if(status and area.get_parent() is Enemy and !area.get_parent().has_node(status)):
		
		#adds status effect to enemy
		print_debug("status applied")
		var new_status = load_status().instantiate()
		new_status.target = area.get_parent()
		area.get_parent().add_child(new_status)
		
		#adds buff to player if their ability level is high enough
		if(buff_player and !PlayerStats.player_ref.has_node(buff)):
			
			#adds buff to player
			print_debug("buff applied")
			var new_buff = load_buff().instantiate()
			new_buff.target = PlayerStats.player_ref
			PlayerStats.player_ref.add_child(new_buff)
			
		elif(buff_player and PlayerStats.player_ref.has_node(buff)):
			#refreshes buff if the player already has the buff
			PlayerStats.player_ref.get_node(buff).refresh()
		
	elif(status and area.get_parent() is Enemy and area.get_parent().has_node(status)):
		#refreshes status if the enemy already has the status
		area.get_parent().get_node(status).refresh()
	
	queue_free()


##projectile will delete itself when colliding with a wall or other collision object
func _on_hitbox_body_entered(_body: Node2D) -> void:
	queue_free()


##returns the scene to be added to the enemy as a child
func load_status() -> PackedScene:
	match status:
		"poison":
			#enables flag for buffing player if ability level is 1 or higher
			if(PlayerStats.RogueClassAbilityLevel >= 1):
				buff_player = true
				buff = "regen"
			
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/poison.tscn")
			
		"slow":
			#enables flag for buffing player if ability level is 2 or higher
			if(PlayerStats.RogueClassAbilityLevel >= 2):
				buff_player = true
				buff = "speed_up"
			
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/slow.tscn")
			
		"weaken":
			#enables flag for buffing player if ability level is 3 or higher
			if(PlayerStats.RogueClassAbilityLevel >= 3):
				buff_player = true
				buff = "damage_up"
			
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/weaken.tscn")
			
		_:
			return null


##returns the scene to be added to the player as a buff
func load_buff() -> PackedScene:
	match buff:
		"regen":
			
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/regen.tscn")
			
		"speed_up":
			
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/speed_up.tscn")
			
		"damage_up":
			
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/damage_up.tscn")
			
		_:
			return load("res://Characters/Player/Scripts/StateMachine/rogue_class/StatusEffects/regen.tscn")

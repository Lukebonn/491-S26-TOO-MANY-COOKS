extends Area2D

var velocity = Vector2.ZERO
var range = 100.0
var speed = 100.0
const KNOCKBACK_FORCE: int = 20
var player_chase=false
var player = null

@onready var temp_health_bar: ProgressBar = $"Temp Health Bar"
var is_alive: bool = true
var health: int = 100

var target = null
var start_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = global_position
	
func set_direction(direction: Vector2, player_level: int):
	speed += 20 * player_level
	range += 10 * player_level
	velocity = direction.normalized() * speed

#function that can be called from the player to deal damage to the slime
func take_damage(self_damage: int, attacker_position: Vector2) -> void: 
	health -= self_damage
	if health <= 0:
		#_die()
		pass
	else:
		print(health)
		#take_damage_sound.play() #pending audio to the take damage
		
		#Knockback
		var knockback_direction = (position - attacker_position).normalized()
		var target_position = position + knockback_direction * KNOCKBACK_FORCE
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "position", target_position, 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += velocity * delta
	if global_position.distance_to(start_position) > range:
		queue_free()

func _on_damage_trigger_area_entered(area: Area2D) -> void:
	if(player):
		take_damage(20,player.position)
	else:
		take_damage(20,Vector2.ZERO)


func _on_body_entered(body: Node2D) -> void:
	if(player):
		take_damage(20,player.position)
	else:
		take_damage(20,Vector2.ZERO)
		
#The function that gives the damage to the player
func get_damage():
	pass
	#return damage

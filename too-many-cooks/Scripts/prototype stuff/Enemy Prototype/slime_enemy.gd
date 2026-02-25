extends CharacterBody2D


const SPEED = 100.0
const KNOCKBACK_FORCE: int = 100
var player_chase=false
var player = null

var is_alive: bool = true
var health: int = 100
var target = null

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var take_damage_sound: AudioStreamPlayer2D = $TakeDamage


func _physics_process(delta: float) -> void:
	if is_alive and target:
		_attack(delta) 
	if player_chase:
		position += (player.position-position)/SPEED
	

func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
	animated_sprite_2d.play("attack_side")
	
#function that can be called from the player to deal damage to the slime
func take_damage(damage: int, attacker_position: Vector2) -> void: 
	health -= damage
	if health <= 0:
		_die()
	else:
		print(health)
		take_damage_sound.play() #pending audio to the take damage
		
		#Knockback
		var knockback_direction = (position - attacker_position).normalized()
		var target_position = position + knockback_direction * KNOCKBACK_FORCE
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "position", target_position, 0.5)
	
	
func _die() -> void:
	is_alive = false
	animated_sprite_2d.play("death")
	
	#disable collision
	$CollisionShape2D.set_deferred("disabled", true)
	$Sight/CollisionShape2D.set_deferred("disabled", true)

func _on_sight_body_entered(body: Node2D) -> void:
	#print(body.name)
	if body.name == "SwordEnemy":
		target = body
	player=body
	player_chase = true


func _on_sight_body_exited(body: Node2D) -> void:
	player=null
	player_chase=false
	if body.name == "SwordEnemy" and is_alive:
		target = null
		animated_sprite_2d.play("idle_front")
		

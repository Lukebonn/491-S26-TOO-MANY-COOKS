extends CharacterBody2D

#for temp health
@onready var temp_health_bar: ProgressBar = $"Temp Health Bar"


const SPEED = 1.0
const KNOCKBACK_FORCE: int = 20
var player_chase=false
var player = null

var is_alive: bool = true
var health: int = 100
#var health: int = EnemyStats.basic_slime_health
var target = null

signal allEnemiesDead()
# Dawson - this signal serves as a marker for when all the enemies
# on the floor have been defeated. As of now, its sole purpose is
# to spawn the exit staircase.

@export var damage = 10
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var take_damage_sound: AudioStreamPlayer2D = $TakeDamage
@onready var damage_numbers_origin = $DamageNumbersOrigin

func _ready():
	temp_health_bar.value = health #attach health bar to enemy

func _physics_process(delta: float) -> void:
	#if is_alive and target:
		#_attack(delta) 
	
	# *note* ideally would put this in take damage but 
	# this health bar is for playtest.
	temp_health_bar.value = health #update enemy health bar
	
	if player_chase:
		position += (player.position-position)*SPEED*delta
	move_and_slide()
	

#func _attack(delta: float) -> void:
	#var direction = (target.position - position).normalized()
	#position += direction * SPEED * delta
	#animated_sprite_2d.play("attack_side")
	
#function that can be called from the player to deal damage to the slime
func take_damage(self_damage: int, attacker_position: Vector2) -> void: 
	health -= self_damage
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
		
		DamageNumbers.display_number(damage, damage_numbers_origin.global_position)
	'''only problem is that its displaying the initial 
	damage for the slime and not the player damage amount.
	Not sure where/what the player stat damage is but
	replace "damage" with PlayerStats.variable_name 
	(whatever the name of player damage is)'''
	
func _die() -> void:
	is_alive = false
	animated_sprite_2d.play("death")
	
	# Dawson - Adds 1 Gold to the Global Gold count
	PlayerStats.Gold += 1
	# Dawson - Spawns the exit staircase
	allEnemiesDead.emit()
	
	#disable collision
	$DamageTrigger/CollisionShape2D.set_deferred("disabled", true)
	$Sight/CollisionShape2D.set_deferred("disabled", true)
	hide()
	

func _on_sight_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Player":
		target = body
		player=body
		player_chase = true


func _on_sight_body_exited(body: Node2D) -> void:
	player=null
	player_chase=false
	if body.name == "Player" and is_alive:
		target = null
		animated_sprite_2d.play("idle_front")

#The function that gives the damage to the player
func get_damage():
	return damage

func _on_damage_trigger_area_entered(area: Area2D) -> void:
	if(player):
		take_damage(20,player.global_position)
	else:
		take_damage(20,Vector2.ZERO)

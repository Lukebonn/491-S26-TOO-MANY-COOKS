extends CharacterBody2D

@export var damage = 10
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var rotation_node: Node2D = $rotationNode
@onready var arrow_start_marker: Marker2D = $rotationNode/arrowStartMarker
@onready var temp_health_bar: ProgressBar = $EnemyHealthBar

const ARROW = preload("res://Objects/Projectiles/magic_default.tscn")

const SPEED = 1.0
const JUMP_VELOCITY = -400.0
const ATTACK_COOLDOWN = 2.0
const KNOCKBACK_FORCE: int = 20

var cooldownCompleted = true
var isShooting = false
var inRange = false
var playerNode = null
var is_alive: bool = true
var health: int = 100
var target = null


func _ready():
	temp_health_bar.value = health #attach health bar to enemy

func _physics_process(delta: float) -> void:
	temp_health_bar.value = health 
	if playerNode:
		_shoot()
	else:
		animated_sprite_2d.play("walk")
	_set_animation()
	
	if inRange:
		position += (playerNode.position-position)*SPEED*delta

func _shoot():
	isShooting = true
	animated_sprite_2d.play("attack")
	cooldownCompleted = false

func _set_animation():	
	if not playerNode: 
		
		return
	
	var playerPosition = playerNode.global_position
	var direction = global_position.direction_to(playerPosition)
	
	if direction.x > 0:
		rotation_node.scale.x = 1
	elif direction.x < 0:
		rotation_node.scale.x = -1

func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation == "attack":
		if animated_sprite_2d.frame == 1:
			_create_arrow()
			#implement later when animation frames don't do the job anymore for a cooldown
			#await get_tree().create_timer(0.5).timeout
			#cooldownCompleted = true
			
func _create_arrow():
	var arrowNode = ARROW.instantiate()
	
	arrowNode.direction = global_position.direction_to(playerNode.global_position)
	
	get_tree().current_scene.add_child(arrowNode)
	arrowNode.global_position = arrow_start_marker.global_position


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "attack":
		isShooting = false
	animated_sprite_2d.play("walk")

func _on_sight_area_entered(body: Area2D) -> void:
	print(body.name)
	if body.name == "Hurtbox":
		playerNode = body
		inRange = true
	#playerNode = body

func _on_sight_area_exited(body: Area2D) -> void:
	if body.name == "Hurtbox":
		playerNode = null
		inRange = false
		animated_sprite_2d.play("idle")
		
#function that can be called from the player to deal damage to the slime
func take_damage(self_damage: int, attacker_position: Vector2) -> void: 
	health -= self_damage
	if health <= 0:
		_die()
	else:
		print(health)

		#Knockback
		var knockback_direction = (position - attacker_position).normalized()
		var target_position = position + knockback_direction * KNOCKBACK_FORCE
 
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "position", target_position, 0.5)
		
		#DamageNumbers.display_number(damage, damage_numbers_origin.global_position)
		#enemy team, i switched up the damage number stuff to be in its own scene
		#this was to de-couple it from a particular enemy
		#the following three lines can become all you need in a enemy death state
		#to display a number
		#let me know if you have questions -carson
		var damage_number = preload("res://Characters/Enemies/Scenes/DamageNumber.tscn").instantiate()
		damage_number.Number = self_damage
		add_child(damage_number)
		
	'''only problem is that its displaying the initial 
	damage for the slime and not the player damage amount.
	Not sure where/what the player stat damage is but
	replace "damage" with PlayerStats.variable_name 
	(whatever the name of player damage is)'''

func _die() -> void:
	is_alive = false
	
	# Dawson - Adds 1 Gold to the Global Gold count
	PlayerStats.Gold += 1
	# Dawson - Spawns the exit staircase (Luke - going to disable this for my map scene)
	#allEnemiesDead.emit()
	
	#disable collision
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$Sight/CollisionShape2D.set_deferred("disabled", true)
	hide()
	#Add the enemy to the player's kill count
	PlayerStats.KillCount += 1
	if Global.Has_Warrior_Quest_1:
		PlayerStats.Quest1EnemiesKOs += 1

#The function that gives the damage to the player
func get_damage():
	return damage

#This is the standard function for when an enemy gets hit by the player
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if(playerNode):
		take_damage(PlayerStats.base_str,playerNode.global_position)
	else:
		take_damage(PlayerStats.base_mag,Vector2.ZERO)

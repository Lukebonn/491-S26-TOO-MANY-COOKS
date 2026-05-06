extends Area2D

@export var damage: int
@export var max_size: float
@export var existence_time: float
@export var summon_time: float
var area_size
var expand = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_size = 0
	scale = Vector2(0, 0)
	$DamageZone.set_deferred("disabled", true)
	await get_tree().create_timer(summon_time).timeout
	$DamageZone.set_deferred("disabled", false)
	expand = true
	await get_tree().create_timer(existence_time).timeout
	expand = false
	$DamageZone.set_deferred("disabled", true)
	await get_tree().create_timer(1.5 * max_size).timeout
	queue_free()

func _process(delta: float) -> void:
	if expand:
		if not area_size >= max_size:
			area_size += 1.0 * delta
	else:
		if not area_size <= 0:
			area_size -= 1.0 * delta
	scale = Vector2(area_size, area_size)

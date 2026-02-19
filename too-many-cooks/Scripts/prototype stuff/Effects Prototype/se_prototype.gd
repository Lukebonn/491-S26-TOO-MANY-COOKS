extends Node2D
@export var health = 100
@export var maxHealth = 100

signal applyPoison(duration)
signal applyRegeneration(duration)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print($HealthBar/HealthValue.text)
	#print($HealthBar.value)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HealthBar/HealthValue.text = str(health)
	$HealthBar.value = health

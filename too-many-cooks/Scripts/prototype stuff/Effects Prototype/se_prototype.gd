extends Node2D
@export var health = 100
@export var displayHealth: int
@export var maxHealth = 100
var statusEffects = []
var effectDurations = []

signal applyPoison(duration)
signal applyRegeneration(duration)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print($HealthBar/HealthValue.text)
	#print($HealthBar.value)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(statusEffects.size()):
		effectDurations[i] -= 1.0 * delta 
		if (effectDurations[i] <= 0):
			effectDurations[i] = -1
			statusEffects[i] = null

	if (statusEffects.has("Poison")):
		health -= 2.0 * delta
	if (statusEffects.has("Regeneration")):
		health += 1.0 * delta
	displayHealth = int(health)
	
	if (health > maxHealth):
		health = maxHealth
	
	
	print(statusEffects)
	print(effectDurations)
	$HealthBar/HealthValue.text = str(displayHealth)
	$HealthBar.value = health

func _on_poison_button_pressed() -> void:
	applyPoison.emit(5)



func _on_heal_button_pressed() -> void:
	applyRegeneration.emit(5)


func _on_effect_clear_button_pressed() -> void:
	statusEffects = []
	effectDurations = []


func _on_apply_poison(duration: Variant) -> void:
	statusEffects.append("Poison")
	effectDurations.append(duration)

func _on_apply_regeneration(duration: Variant) -> void:
	statusEffects.append("Regeneration")
	effectDurations.append(duration)

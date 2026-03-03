extends Node2D

@export var mana = 100
@export var displayMana: int
@export var maxMana = 100


@export var health = 100
# behind the scenes health value, calculated as a float.
@export var displayHealth: int
# the health value displayed in the game, expressed as an int.
@export var maxHealth = 100
# the maximum health the "player" can have.
var statusEffects = []
# contains a list of status effects applied to the "player."
var effectDurations = []
# contains the durations of the status effects at the corresponding index.
var cleanUp = []
# This array will store the indexes of the status effects that have expired.
# Before processing effects again, if there are any expired effects in this
# array, then they will be removed from the lists.

# deprecated signals. Now condensed into one all-inclusive signal!
#signal applyPoison(duration) # a signal to apply posion of a set duration.
#signal applyRegeneration(duration) # a signal to apply regeneration of a set duration.

signal applyStatusEffect(effectName: String, duration: int)
# applies a specified status effect for a specified duration, in seconds; following
# a few simple rules. See function "_on_apply_status_effect()" for more details.
# Technically, this signal can be used to apply functionless status effects.
# for example, applyStatusEffect("Beef Stroganoff", 10)
# effects only have an effect if their effect/function is defined in the code.
# in this prototype, only "Poison" and "Regeneration" have defined functions,
# and thus, are the only two effects that do something.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# testing purposes
	#print($HealthBar/HealthValue.text)
	#print($HealthBar.value)
	#applyStatusEffect.emit("Poison", 20)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if there are any expired effects in "cleanUp," then
	# iterate through the array of indexes with expired effects,
	# and remove them from the respective arrays.
	if not cleanUp.size() == 0:
		for i in range(cleanUp.size()):
			effectDurations.remove_at(i)
			statusEffects.remove_at(i)
	# once any and all expired effect have been removed, reset
	# the cleanUp array.
	cleanUp = []
	
	# after clean up, iterate through the list of active status effects
	# and reduce their duration (since a frame has passed).
	# if there are any status effects that will expire in this frame,
	# set their values to something impossible (null and -1, respectively),
	# and add the index of this effect to the cleanUp array (to be removed next frame).
	for i in range(statusEffects.size()):
		effectDurations[i] -= 1.0 * delta 
		if (effectDurations[i] <= 0):
			effectDurations[i] = -1
			statusEffects[i] = null
			cleanUp.append(i)

	# after handing any and all effects, check the list of active effects
	# and carry out their functions.
	# these conditionals check for the first instance of each effect.
	# Meaning, repeated instances do not have any additional effect.
	if (statusEffects.has("Poison")):
		health -= 5.0 * delta # the poison effect removes 2 health per second.
	if (statusEffects.has("Regeneration")):
		health += 5.0 * delta # the regeneration effect heals 1 health per second.
	displayHealth = int(health)
	displayMana = int(mana)
	# updates the value for displayHealth to display it as an integer.
	
	# the following conditional ensures that the player's health
	# cannot exceed their max health.
	if (health > maxHealth):
		health = maxHealth
	if (health < 0):
		health = 0
	
	# testing purposes
	print(statusEffects)
	print(effectDurations)
	
	

func _on_poison_button_pressed() -> void:
	#applyPoison.emit(5) 
	applyStatusEffect.emit("Poison", 5) # Applies poison for 5 seconds.
	# The duration of the effect can be changed.



func _on_heal_button_pressed() -> void:
	#applyRegeneration.emit(5) 
	applyStatusEffect.emit("Regeneration", 5) # Applies regeneration for 5 seconds.
	# The duration of the effect can be changed.


func _on_effect_clear_button_pressed() -> void:
	statusEffects = []
	effectDurations = []
	# uhhh I think this one clears all active status effects.
	# not sure, but check up on this one.


#deprecated functions that have been collapsed into one all-inclusive function!
#func _on_apply_poison(duration: Variant) -> void:
	#if (statusEffects.has("Poison")):
		#effectDurations[statusEffects.find("Poison")] = duration
	#else:
		#statusEffects.append("Poison")
		#effectDurations.append(duration)
#
#
#func _on_apply_regeneration(duration: Variant) -> void:
	#if (statusEffects.has("Regeneration")):
		#effectDurations[statusEffects.find("Regeneration")] = duration
	#else:
		#statusEffects.append("Regeneration")
		#effectDurations.append(duration)
		

func _on_apply_status_effect(effectName: String, duration: int) -> void:
	if (statusEffects.has(effectName)):
		if duration > effectDurations[statusEffects.find(effectName)]:
				effectDurations[statusEffects.find(effectName)] = duration
	else:
		statusEffects.append(effectName)
		effectDurations.append(duration)
# In short, this function applies or refreshes a select status effect for a select duration.
# In long, this function first checks to see if the effect-to-be-applied is already
# applied. 
	# If it already exists, then do not add another instance of the effect, and
	# instead, update the duration of the effect to the new value. Effectively, this
	# refreshes the buff with the new duration (provided that the new duration is greater
	# than the old duration).
	# If the effect does not already exist, then apply the specified effect with the 
	# specified duration.

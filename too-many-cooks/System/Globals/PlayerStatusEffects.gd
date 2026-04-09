extends Node

var player

var statusEffects = []
# contains a list of status effects applied to the "player."
var effectDurations = []
# contains the durations of the status effects at the corresponding index.
var cleanUp = []
# This array will store the indexes of the status effects that have expired.
# Before processing effects again, if there are any expired effects in this
# array, then they will be removed from the lists.

signal applyStatusEffect(effectName: String, duration: int)
# applies a specified status effect for a specified duration, in seconds; following
# a few simple rules. See function "_on_apply_status_effect()" for more details.
# Technically, this signal can be used to apply functionless status effects.
# for example, applyStatusEffect("Beef Stroganoff", 10) will apply the status effect
# "Beef Stroganoff" for 10 seconds.
# effects only have an effect if their effect/function is defined in the code.
# in this prototype, only "Poison" and "Regeneration" have defined functions,
# and thus, are the only two effects that do something.

func _ready() -> void:
	player = %Player

func _process(delta: float) -> void:
	if !player:
		pass
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
		player.health -= 2.0 * delta # the poison effect removes 2 health per second.
	if (statusEffects.has("Regeneration")):
		player.health += 1.0 * delta # the regeneration effect heals 1 health per second.

func _on_apply_status_effect(effectName: String, duration: int) -> void:
	if (statusEffects.has(effectName)):
		if duration > effectDurations[statusEffects.find(effectName)]:
				effectDurations[statusEffects.find(effectName)] = duration
	else:
		statusEffects.append(effectName)
		effectDurations.append(duration)

extends Control

var player: Node # stores a reference to the player node in the Combat Scene.

signal flashManaBar()

var warrior_quest_1 = "Quest: Kill 10 enemies"

var mage_quest_1 = "Quest: Get an orb"
#var statusEffects = []
## contains a list of status effects applied to the "player."
#var effectDurations = []
## contains the durations of the status effects at the corresponding index.
#var cleanUp = []
## This array will store the indexes of the status effects that have expired.
## Before processing effects again, if there are any expired effects in this
## array, then they will be removed from the lists.

# deprecated signals. Now condensed into one all-inclusive signal!
#signal applyPoison(duration) # a signal to apply posion of a set duration.
#signal applyRegeneration(duration) # a signal to apply regeneration of a set duration.

#signal applyStatusEffect(effectName: String, duration: int)
## applies a specified status effect for a specified duration, in seconds; following
## a few simple rules. See function "_on_apply_status_effect()" for more details.
## Technically, this signal can be used to apply functionless status effects.
## for example, applyStatusEffect("Beef Stroganoff", 10) will apply the status effect
## "Beef Stroganoff" for 10 seconds.
## effects only have an effect if their effect/function is defined in the code.
## in this prototype, only "Poison" and "Regeneration" have defined functions,
## and thus, are the only two effects that do something.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DeathScreen.visible = false
	if $"../../Player":
		player = $"../../Player"
		player.connect("notEnoughMana", _on_player_not_enough_mana)
		
		#catch case, we don't want "You Died!" screen in intro combat
		if get_tree().current_scene.name != "IntroCombat":
			player.connect("playerDeath", _on_player_death)
		print("hi")
	show()
	#print(player)
	# testing purposes
	#print($HealthBar/HealthValue.text)
	#print($HealthBar.value)
	#applyStatusEffect.emit("Poison", 20)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player:
		pass
	else:
		
		# ensures that the player's Health can only ever be between
		# 0 and the player's Max Health.
		player.health = clamp(player.health, 0, PlayerStats.MaxHealth)
		player.mana = clamp(player.mana, 0, PlayerStats.MaxMana)
		
		player.displayHealth = int(round(player.health))
		player.displayMana = int(player.mana)
		# updates the values for displayHealth & displayMana 
		# to display as integers.
		
		## if there are any expired effects in "cleanUp," then
		## iterate through the array of indexes with expired effects,
		## and remove them from the respective arrays.
		#if not cleanUp.size() == 0:
			#for i in range(cleanUp.size()):
				#effectDurations.remove_at(i)
				#statusEffects.remove_at(i)
		## once any and all expired effect have been removed, reset
		## the cleanUp array.
		#cleanUp = []
		#
		## after clean up, iterate through the list of active status effects
		## and reduce their duration (since a frame has passed).
		## if there are any status effects that will expire in this frame,
		## set their values to something impossible (null and -1, respectively),
		## and add the index of this effect to the cleanUp array (to be removed next frame).
		#for i in range(statusEffects.size()):
			#effectDurations[i] -= 1.0 * delta 
			#if (effectDurations[i] <= 0):
				#effectDurations[i] = -1
				#statusEffects[i] = null
				#cleanUp.append(i)

		## after handing any and all effects, check the list of active effects
		## and carry out their functions.
		## these conditionals check for the first instance of each effect.
		## Meaning, repeated instances do not have any additional effect.
		#if (statusEffects.has("Poison")):
			#player.health -= 2.0 * delta # the poison effect removes 2 health per second.
		#if (statusEffects.has("Regeneration")):
			#player.health += 1.0 * delta # the regeneration effect heals 1 health per second.
		quest_received()
	
	
	
	# testing purposes
	#print(statusEffects)
	#print(effectDurations)
	
	
func _on_player_not_enough_mana() -> void:
	flashManaBar.emit()
	print("Yo whatsuo")
	# this signal tells the Mana bar to flash, indicating to the
	# player that they do not have enough Mana.
# Takes a singal and emits another signal that is more local to the
# Mana bar node. Yes, it might be redundant to emit a signal from
# another signal, but I couldn't think of another way to do this.

func _on_player_death() -> void:
	await get_tree().create_timer(1.0).timeout
	$DeathScreen.visible = true
	# When the player unfortunately passes away, 
	# wait 1 second, then display the death screen.

func _on_retry_button_button_down() -> void:
	PlayerStats.Gold = PlayerStats.temp_gold
	PlayerStats.Orbs = PlayerStats.temp_orb
	get_tree().reload_current_scene()
	# restarts the combat scene


func _on_return_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")
	# takes the player back to the tavern

func quest_received():
	if Global.Has_Warrior_Quest_1:
		$Quest.set_text(warrior_quest_1 + " %d / 10" % [PlayerStats.Quest1EnemiesKOs])
		if PlayerStats.Quest1EnemiesKOs >= 10:
			$Quest.set_text("Quest complete! Talk to Warrior!")
	if Global.Has_Mage_Quest_1:
		$Quest.set_text(mage_quest_1 + " %d / 1" % [PlayerStats.Quest1Orbs])
		if PlayerStats.Quest1Orbs >= 1:
			$Quest.set_text("Quest complete! Talk to Mage!")
	if PlayerStats.quests > 1:
		if $Quest.text == (mage_quest_1 + " %d / 1" % [PlayerStats.Quest1Orbs]):
			$Quest2.set_text(warrior_quest_1 + " %d / 10" % [PlayerStats.Quest1EnemiesKOs])
			if PlayerStats.Quest1EnemiesKOs >= 10:
				$Quest2.set_text("Quest complete! Talk to Warrior!")
		elif $Quest.text == (warrior_quest_1 + " %d / 10" % [PlayerStats.Quest1EnemiesKOs]):
			$Quest2.set_text(mage_quest_1 + " %d / 1" % [PlayerStats.Quest1Orbs])
			if PlayerStats.Quest1Orbs >= 1:
				$Quest2.set_text("Quest complete! Talk to Mage!")

#func _on_poison_button_pressed() -> void:
	##applyPoison.emit(5) 
	#applyStatusEffect.emit("Poison", 5) # Applies poison for 5 seconds.
	## The duration of the effect can be changed.
	## this is effectively a deprecated function, as the test buttons
	## used to clear and add status effects are hidden.
#
#
#
#func _on_heal_button_pressed() -> void:
	##applyRegeneration.emit(5) 
	#applyStatusEffect.emit("Regeneration", 5) # Applies regeneration for 5 seconds.
	## The duration of the effect can be changed.
	## this is effectively a deprecated function, as the test buttons
	## used to clear and add status effects are hidden.
#
#
#func _on_effect_clear_button_pressed() -> void:
	#statusEffects = []
	#effectDurations = []
	## uhhh I think this one clears all active status effects.
	## not sure, but check up on this one.
	## this is effectively a deprecated function, as the test buttons
	## used to clear and add status effects are hidden.


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
		

#func _on_apply_status_effect(effectName: String, duration: int) -> void:
	#if (statusEffects.has(effectName)):
		#if duration > effectDurations[statusEffects.find(effectName)]:
				#effectDurations[statusEffects.find(effectName)] = duration
	#else:
		#statusEffects.append(effectName)
		#effectDurations.append(duration)
# In short, this function applies or refreshes a select status effect for a select duration.
# In long, this function first checks to see if the effect-to-be-applied is already
# applied. 
	# If it already exists, then do not add another instance of the effect, and
	# instead, update the duration of the effect to the new value. Effectively, this
	# refreshes the buff with the new duration (provided that the new duration is greater
	# than the old duration).
	# If the effect does not already exist, then apply the specified effect with the 
	# specified duration.


func _on_pause_retry_button_down() -> void:
	get_tree().paused = false
	PlayerStats.Gold = PlayerStats.temp_gold
	PlayerStats.Orbs = PlayerStats.temp_orb
	get_tree().reload_current_scene()


func _on_retry_return_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")

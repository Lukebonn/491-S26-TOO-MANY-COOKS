extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = PlayerStats.MaxMana
	# ensures that the maximum value for the Mana bar matches 
	# that of the player's max Mana.
	self_modulate = Color(10, 0.0, 10, 1.0)
	# sets the color of the Mana bar to be whatever this color is!


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not get_parent().player:
		pass
	else:
		
		value = get_parent().player.displayMana
		$ManaValue.text = str(get_parent().player.displayMana)
		# These two lines of code make sure that the values on the bar
		# are always up to date.
		
		# Deprecated "spell" function that gave the player regeneration for
		# 5 seconds at the cost of 20 Mana.
		#if Input.is_action_just_pressed("use_item"):
			#if (get_parent().player.displayMana >= 20):
				#get_parent().player.mana -= 20
				#get_parent().applyStatusEffect.emit("Regeneration", 5)
			#else:
				#print("You don't have enough Mana to do this.")
		
		# clamps the values of the Mana bar to be between 0 and the max Mana value.
		get_parent().player.mana = clamp(get_parent().player.mana, 0, PlayerStats.MaxMana)


func _on_flash_mana_bar() -> void:
	self_modulate = Color(5.0, 5.0, 5.0, 1.0)
	await get_tree().create_timer(0.1).timeout
	self_modulate = Color(10, 0.0, 10, 1.0)
# When the player does not have enough Mana to cast their spell, the
# bar will flash to indicate to the player that they don't have enough Mana.

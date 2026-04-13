extends TextureProgressBar
var enteredCriticalHealth = false
var flash = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = PlayerStats.MaxHealth
	# ensures that the maximum value for the Health bar matches 
	# that of the player's max Health.
	#self_modulate = Color(10.0, 0.0, 0.0, 1.0)
	## sets the color of the Health bar to be red

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not get_parent().player:
		pass
	else:
		value = get_parent().player.displayHealth
		$HealthValue.text = str(get_parent().player.displayHealth)
		
		# These two lines of code make sure that the values on the bar
		# are always up to date.
		
		# this conditional checks to see if the player's current Health is
		# less than or equal to 10% of the player's max Health.
			# If it is at less than or equal to 10%, the Health bar will
			# begin to flash.
				# And if the player's Health reaches 0, then the bar will
				# stop flashing and turn black.
			# If it is not, the Health bar assumes its normal red color...
			# UNLESS the player currently has an active status effect.
		if get_parent().player.displayHealth <= (PlayerStats.MaxHealth / 10):
			if (enteredCriticalHealth == false):
				$Timer.start(0.1)
				# this timer is used to specify how fast the health bar should flash
				enteredCriticalHealth = true
			if (get_parent().player.displayHealth == 0):
				# if the player's health reaches 0 (when they "die")
				# stop the health bar from flashing, and set the color
				# of the health bar to black
				#self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				$Timer.stop() # Stops the flash timer, as the player has died.
				enteredCriticalHealth = false # used to stop the flashing
		else: # this code will only run if the player is not in critical health
			# effectively meaning that the health bar flashing has priority 
			# over anything else.
			enteredCriticalHealth = false
			$Timer.stop() 
			# prevents the flash timer from starting because the player
			# should not be in critical health.
			self_modulate = Color(1.0, 1.0, 1.0, 1.0)
			# changes color of the Health bar to its default, in case
			# it needs to be changed by any status effects.
			if PlayerStatusEffects.statusEffects.has("Regeneration"):
				self_modulate = Color(10.0, 0.0, 5.69, 1.0)
			if PlayerStatusEffects.statusEffects.has("Poison"):
				self_modulate = Color(0.0, 6.47, 0.0, 1.0)
			#There is a hierarchy in terms of which status effect changes
			#the color of the health bar. It would be beneficial if 
			#NEGATIVE STATUS EFFECTS (i.e. Poison or maybe Fire) had a
			#higher priority than positive status effects.
			#the Poison effect has precedence over Regeneration.

func _on_timer_timeout() -> void:
	if (flash == true):
		self_modulate = Color(5.0, 5.0, 5.0, 1.0)
		flash = false
	else:
		self_modulate = Color(1.0, 1.0, 1.0, 1.0)
		flash = true
	# woaw this code makes the health bar flash how awesome.

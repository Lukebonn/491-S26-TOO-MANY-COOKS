extends ProgressBar
var enteredCriticalHealth = false
var flash = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = get_parent().maxHealth
	self_modulate = Color(10.0, 0.0, 0.0, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = get_parent().displayHealth
	$HealthValue.text = str(get_parent().displayHealth)
	if get_parent().displayHealth <= (get_parent().maxHealth / 10):
		if (enteredCriticalHealth == false):
			$Timer.start(0.1)
			# this timer is used to specify how fast the health bar should flash
			enteredCriticalHealth = true
		if (get_parent().displayHealth == 0):
			# if the player's health reaches 0 (when they "die")
			# stop the health bar from flashing, and set the color
			# of the health bar to black
			self_modulate = Color(0.0, 0.0, 0.0, 1.0)
			$Timer.stop()
			enteredCriticalHealth = false # used to stop the flashing
	else:
		enteredCriticalHealth = false
		$Timer.stop()
		self_modulate = Color(10.0, 0.0, 0.0, 1.0)
		if get_parent().statusEffects.has("Regeneration"):
			self_modulate = Color(10.0, 0.0, 5.69, 1.0)
		if get_parent().statusEffects.has("Poison"):
			self_modulate = Color(0.0, 6.47, 0.0, 1.0)
		

func _on_timer_timeout() -> void:
	if (flash == true):
		self_modulate = Color(5.0, 5.0, 5.0, 1.0)
		flash = false
	else:
		self_modulate = Color(10.0, 0.0, 0.0, 1.0)
		flash = true

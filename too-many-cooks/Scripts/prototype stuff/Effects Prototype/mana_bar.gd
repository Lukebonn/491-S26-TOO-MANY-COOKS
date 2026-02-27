extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = get_parent().maxMana
	self_modulate = Color(10, 0.0, 10, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = get_parent().displayMana
	$ManaValue.text = str(get_parent().displayMana)
	
	if Input.is_action_just_pressed("use_item"):
		if (get_parent().mana >= 20):
			get_parent().mana -= 20
			get_parent().applyStatusEffect.emit("Regeneration", 5)
		else:
			print("You don't have enough Mana to do this.")

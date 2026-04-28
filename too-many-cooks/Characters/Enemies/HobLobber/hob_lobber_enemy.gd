extends Enemy


func _ready():
	current_state = starting_state
	current_state.enter_state(self)
	current_health = health
	player_ref = get_tree().get_first_node_in_group("Player")
	$AnimatedSprite2D.modulate=Color(0.0, 0.806, 0.0, 1.0)

func _on_sight_body_entered(body):
	if body.name == "Player":
		player_ref = body
		player_in_sight = true
		change_state("ProjectileState")

func change_state(new_state : String):
	if !current_state: #just in case current_state is null for some reason
		current_state.exit_state()
		current_state.enter_state("IdleState")
	print("Switching to enemy state: " + new_state)
	current_state = get_node(new_state)
	current_state.enter_state(self)

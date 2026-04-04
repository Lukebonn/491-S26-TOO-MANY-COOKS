extends EnemyState
#for picking between 2 or more states
#you can "weight" these by having multiple of a state in possibilities

@export var Possibilities : Array[EnemyState]

func enter_state(enemy_node):
	super(enemy_node)
	var rng = randi_range(0,(Possibilities.size()-1))
	var chosen_state = Possibilities[rng]
	print("The junction has chosen " + str(chosen_state))
	enemy_ref.change_state(str(chosen_state))

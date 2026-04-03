extends Node

@export var particles: GPUParticles2D
@export var color_rect: ColorRect

@onready var rain_state_machine = $RainStateMachine
@onready var fog_state_machine = $FogStateMachine
@onready var wind_state_machine = $WindStateMachine

func _ready():
	#change_to(Breeze)
	#change_to(Drizzle)
	#change_to(Fog)
	#OR
	change_to_list([Breeze,Drizzle, Fog])


func change_to(new_state):
	if new_state.type == "Rain":
		rain_state_machine.state = new_state.new(particles)
	elif new_state.type == "Fog":
		fog_state_machine.state = new_state.new(color_rect)
	elif new_state.type == "Wind":
		wind_state_machine.state = new_state.new(get_tree())
		

#add to a list instead
func change_to_list(list_of_states):
	for state in list_of_states:
		change_to(state)

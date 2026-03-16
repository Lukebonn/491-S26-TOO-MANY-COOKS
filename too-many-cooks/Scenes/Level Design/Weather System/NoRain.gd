extends "res://Scenes/Level Design/Weather System/RainStates.gd"
#extends Rainstate

class_name NoRain

var emitter: GPUParticles2D

func _init(particle_emitter):
	emitter = particle_emitter

func enter():
	emitter.process_material = null
	emitter.emitting = false
	#emitter.amount = 0

#func exit():
#	pass

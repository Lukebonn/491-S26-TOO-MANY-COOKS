extends "res://Scenes/Level Design/Weather System/RainStates.gd"
#extends Rainstate

class_name HeavyRain

var emitter: GPUParticles2D

func _init(particle_emitter):
	emitter = particle_emitter

func enter():
	emitter.process_material = load("res://Scenes/Level Design/Weather System/HeavyRain.tres")
	emitter.emitting = true
	emitter.amount = 300
	
func exit():
	emitter.process_material = null
	emitter.emitting = false

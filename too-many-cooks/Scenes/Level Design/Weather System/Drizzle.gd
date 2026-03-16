extends "res://Scenes/Level Design/Weather System/RainStates.gd"
#extends Rainstate

class_name Drizzle

var emitter: GPUParticles2D

func _init(particle_emitter):
	emitter = particle_emitter

func enter():
	emitter.process_material = load("res://Scenes/Level Design/Weather System/Drizzle.tres")
	emitter.emitting = true
	emitter.amount = 20

func exit():
	emitter.process_material = null
	emitter.emitting = false

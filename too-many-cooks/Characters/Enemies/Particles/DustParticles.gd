extends Node2D

@onready var particles = $GPUParticles2D

func _ready():
	print("DUST READY, particles node: ", particles)
	if particles:
		particles.emitting = true
		print("EMITTING: ", particles.emitting)
		print("AMOUNT: ", particles.amount)
		print("LIFETIME: ", particles.lifetime)
	await get_tree().create_timer(1.0).timeout
	queue_free()

extends Area2D

##The Spawners to activate when this Room is "entered."
@export var Spawners : Array[Node2D]
##The Barriers to activate when this Room is "entered."
@export var Barriers : Array[Node2D]
var touched = false
var count = 0
var active = true

func _ready() -> void:
	for s in Spawners:
		s.connect("on_all_dead", add_count)
		s.connect("on_destroyed", add_count)

func add_count() -> void:
	if active:
		count += 1
		if count >= Spawners.size():
			stop_room()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && not touched:
		touched = true
		start_room()

func start_room() -> void:
	#Start room sequence.
	for s in Spawners:
		s.try_spawn_enemies()
	for b in Barriers:
		b.call_deferred("make_visible")

func stop_room() -> void:
	active = false
	for b in Barriers:
		b.call_deferred("destroy_barrier")

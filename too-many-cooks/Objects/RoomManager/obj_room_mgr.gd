extends Area2D

#Emitted when a Room begins.
signal on_room_start
#Emitted when a Room ends.
signal on_room_end
#Emitted when a Room's Spawner is finished.
#If 1 Spawner is assigned, use on_room_end instead!
signal on_spawner_finished

##The Spawners to activate when this Room is "entered."
@export var Spawners : Array[Node2D]
##The Barriers to activate when this Room is "entered."
@export var Barriers : Array[Node2D]
var touched = false
var count = 0
var active = true

# ! For logic to change in Barriers, change their respective visible/destroy functions.
# Signals for this are a bit redundant since Barrier states are already handled via function call.
signal close_barriers
signal open_barriers

func _ready() -> void:
	for s in Spawners:
		s.connect("on_all_dead", add_count)
		s.connect("on_destroyed", add_count)

func add_count() -> void:
	if active:
		count += 1
		on_spawner_finished.emit()
		if count >= Spawners.size():
			stop_room()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && not touched:
		touched = true
		start_room()

func start_room() -> void:
	#Start room sequence.
	close_barriers.emit()
	on_room_start.emit()
	for s in Spawners:
		s.try_spawn_enemies()
	if Barriers.size() > 0:
		for b in Barriers:
			b.call_deferred("make_visible")

func stop_room() -> void:
	open_barriers.emit()
	on_room_end.emit()
	active = false
	for b in Barriers:
		b.call_deferred("destroy_barrier")

extends Area2D

@export var number_of_enemies: int

var doors: Array = []
var in_battle = false
var entered: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get only the doors that are children to this "room"
	doors = get_tree().get_nodes_in_group("door").filter(
		func(d): return is_ancestor_of(d)
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_battle and EnemyStats.enemies_in_room == 0:
		unlock_all_doors()


func _on_body_entered(body: Node2D) -> void:
	print(body.name + " has entered room")
	if body.name == "Player":
		lock_all_doors()

func lock_all_doors() -> void:
	if entered >= 1:
		print("room already cleared")
		return
	entered += 1
	in_battle = true
	print(EnemyStats.enemies_in_room)
	for door in doors:
		door.set_locked(true)
	EnemyStats.enemies_in_room = number_of_enemies

func unlock_all_doors() -> void:
	in_battle = false
	for door in doors:
		door.set_locked(false)
		

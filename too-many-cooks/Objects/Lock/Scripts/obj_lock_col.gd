extends Area2D

var lock : Node2D
#Ref to parent Lock.

func _ready() -> void:
	lock = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		lock.unlock()
		#if body.num_keys > 0:
			#lock.unlock()
			#body.num_keys -= 1

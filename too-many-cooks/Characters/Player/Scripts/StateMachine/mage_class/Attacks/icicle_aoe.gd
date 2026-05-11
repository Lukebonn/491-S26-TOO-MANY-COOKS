extends StaticBody2D

var damage : int

##sets damage to the same as the icicle projectile
func _ready():
	damage = int(((PlayerStats.base_str + PlayerStats.passive_str) * 1.3)/2)

##deletes itself immediately after being spawned in
func _on_timer_timeout():
	queue_free()

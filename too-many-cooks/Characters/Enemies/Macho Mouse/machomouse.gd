extends Enemy

@export var smash_range: float = 28.0 #was 28
@export var smash_cooldown: float = 1.5

var can_smash := true
var is_smashing := false

func _ready():
	super()
	set_hitbox_active(false)
	hide_attack_warning()

func player_in_smash_range() -> bool:
	if not player_ref:
		return false
	
	#print(global_position.distance_to(player_ref.global_position))
	return global_position.distance_to(player_ref.global_position) <= smash_range

func reset_smash():
	await get_tree().create_timer(smash_cooldown).timeout
	can_smash = true

func set_hitbox_active(active: bool):
	$Hitbox.monitoring = active
	$Hitbox.monitorable = active

func show_attack_warning():
	$AttackWarning.show_warning()

func hide_attack_warning():
	$AttackWarning.hide_warning()

func _on_hurtbox_body_entered(_body):
	pass

func _on_hurtbox_area_entered(area):
	var source = area.get_parent()
	
	if source and "damage" in source:
		take_damage(source.damage)

func _on_hitbox_body_entered(_body):
	pass

func _on_hitbox_area_entered(_area):
	pass

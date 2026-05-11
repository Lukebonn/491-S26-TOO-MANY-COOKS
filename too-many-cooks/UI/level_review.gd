extends Node2D
signal show_result
func _ready() -> void:
	$"Gold Collected".hide()
	$"Orbs Collected".hide()
	$"Enemies Killed".hide()
	$"Level Time".hide()
	$"Damage Taken".hide()
	$"Damage Dealt".hide()
	$"Objective Title".hide()
	$AdvanceButton.hide()

func reveal():
	var dim = get_tree().create_tween()
	dim.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	dim.tween_property($"../BgDim","color",Color(0.0, 0.0, 0.0, 0.588),.25)
	
	var tween = self.create_tween()
	tween.tween_property(
		self,
		"position",
		Vector2(0,0),
		0.5).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(1.0).timeout
	
	var tween2 = $LevelComplete.create_tween()
	tween2.tween_property(
		$LevelComplete,
		"position",
		Vector2(232,139),
		0.5).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(0.25).timeout
	$"Gold Collected".show()
	$"Level Time".show()
	await get_tree().create_timer(0.5).timeout
	$"Orbs Collected".show()
	$"Damage Taken".show()
	await get_tree().create_timer(0.5).timeout
	$"Enemies Killed".show()
	$"Damage Dealt".show()
	await get_tree().create_timer(0.5).timeout
	$"Objective Title".show()
	await get_tree().create_timer(0.5).timeout
	if (LevelQueue.Queue.size() == 0):
		$AdvanceButton.text = "Back to Tavern"
	else:
		$AdvanceButton.text = "Next Level"
	$AdvanceButton.show()
	show_result.emit()


func _on_objective_manager_give_report_data(obj_title, result):
	$"Objective Title".text = obj_title
	await show_result
	if result == true:
		$"Objective Title/Objective Check".show()
		var new_reward = preload("res://UI/objective_reward_fx.tscn").instantiate()
		new_reward.global_position = $"Objective Title/Objective Frame".global_position
		add_child(new_reward)
	else:
		$"Objective Title/Objective Cross".show()
		

extends Node2D

func _ready() -> void:
	$"Gold Collected".hide()
	$"Orbs Collected".hide()
	$"Enemies Killed".hide()
	$"Level Time".hide()
	$"Damage Taken".hide()
	$"Damage Dealt".hide()
	$"le objectives".hide()
	$AdvanceButton.hide()
	
func reveal():
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
	$"le objectives".show()
	await get_tree().create_timer(0.5).timeout
	if (LevelQueue.Queue.size() == 0):
		$AdvanceButton.text = "Back to Tavern"
	else:
		$AdvanceButton.text = "Next Level"
	$AdvanceButton.show()

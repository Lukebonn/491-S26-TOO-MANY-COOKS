extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#print(Global.First_Time_Tavern)
	#if Global.First_Time_Tavern:
		#show()
	pass
		


func _on_button_one_pressed():
	$FirstPanel.hide()
	$SecondPanel.show()
	


func _on_button_two_pressed():
	$SecondPanel.hide()
	$ThirdPanel.show()


func _on_button_three_pressed():
	$ThirdPanel.hide()
	$FourthPanel.show()


func _on_button_four_pressed():
	$FourthPanel.hide()
	Global.First_Time_Tavern = false

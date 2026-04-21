extends Control
@export var clickSound : AudioStreamPlayer
@export var hoverSound : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(Global.First_Time_Tavern)
	#if Global.First_Time_Tavern:
		#show()
	pass
		


func _on_button_one_pressed():
	clickSound.play()
	$FirstPanel.hide()
	$SecondPanel.show()
	


func _on_button_two_pressed():
	clickSound.play()
	$SecondPanel.hide()
	$ThirdPanel.show()


func _on_button_three_pressed():
	clickSound.play()
	$ThirdPanel.hide()
	$FourthPanel.show()


func _on_button_four_pressed():
	clickSound.play()
	$FourthPanel.hide()
	Global.First_Time_Tavern = false


func _on_button_mouse_entered() -> void:
	hoverSound.play()

extends Node2D

func _ready():
	make_list()

func make_list():
	$RichTextLabel.text = ""
	for slot in $Inventory.item_slots:
		if(slot.item != null):
			$RichTextLabel.text += slot.item.name + " (" +str(slot.quantity) + ")" + "\n"

func _on_add_button1_pressed():
	$Inventory.add_item(load("res://Scripts/prototype stuff/items/Test_Item_1.tres"))

func _on_add_button_2_pressed():
	$Inventory.add_item(load("res://Scripts/prototype stuff/items/Test_Item_2.tres"))

func _on_remove_button_1_pressed():
	$Inventory.remove_item(load("res://Scripts/prototype stuff/items/Test_Item_1.tres"))

func _on_remove_button_2_pressed():
	$Inventory.remove_item(load("res://Scripts/prototype stuff/items/Test_Item_2.tres"))

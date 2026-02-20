class_name Inventory
extends Node

class ItemSlot:
	var item : ItemData
	var quantity : int = 0

var item_slots : Array[ItemSlot]
@export var starting_items : Dictionary[ItemData, int]

@export var inv_size : int = 10

signal inventory_updated
signal slot_updated

##instantiates new ItemSlots equal to inv_size
#adds items from starting_items to item_slots
func _ready() -> void:
	for i in range(inv_size):
		item_slots.append(ItemSlot.new())
	
	for key in starting_items:
		for i in range(starting_items[key]):
			add_item(key)

##adds item to slot containing that item or to an empty slot
#item: ItemData to be added
#returns false if item cannot be added
func add_item(item : ItemData) -> bool:
	var slot = get_available_slot_with(item)
	if slot == null:
		slot = get_empty_slot()
		
		if(slot == null):
			return false
		
		slot.item = item
		slot.quantity = 1
	else:
		slot.quantity += 1
	
	inventory_updated.emit()
	slot_updated.emit()
	return true

##removes item from inventory
#item: ItemData to be removed
func remove_item(item : ItemData):
	var slot = get_slot_with(item)
	if(slot):
		if(slot.quantity > 1):
			slot.quantity -= 1
		else:
			slot.item = null
			slot.quantity = 0
		
		inventory_updated.emit()
		slot_updated.emit()

##removes item from specified slot
#slot: ItemSlot to be emptied
func remove_item_from_slot(slot : ItemSlot):
	slot.item = null
	slot.quantity = 0
	
	inventory_updated.emit()
	slot_updated.emit()

##returns the item stored in slot parameter
#slot: ItemSlot to be searched
func get_item_from(slot : ItemSlot) -> ItemData:
	return slot.item

##returns the first item slot that has the item in the parameter
#item: ItemData that specifies the item to be found
func get_slot_with(item : ItemData) -> ItemSlot:
	for slot in item_slots:
		if slot.item == item:
			return slot
	
	return null

##returns the first item slot with the item parameter but is not a full stack
#item: ItemData that specifies the item to be found
func get_available_slot_with(item : ItemData) -> ItemSlot:
	for slot in item_slots:
		if slot.item == item and slot.quantity < item.max_stack:
			return slot
	
	return null

##returns the first empty slot
#returns null if no empty slots are found
func get_empty_slot() -> ItemSlot:
	for slot in item_slots:
		if slot.item == null:
			return slot
	
	return null

##checks inventory for item in parameter
#item: ItemData that the function is looking for
#returns false if item is not found
func check_inventory(item : ItemData) -> bool:
	for slot in item_slots:
		if slot.item == item:
			return true
	
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

class_name Inventory
extends Resource

class ItemSlot:
	var item : ItemData
	var quantity : int = 0

var item_slots : Array[ItemSlot]
@export var starting_items : Dictionary[ItemData, int]

@export var inv_size : int = 10

signal inventory_updated
signal slot_updated

#instantiates new ItemSlots equal to inv_size
func _ready() -> void:
	for i in range(inv_size):
		item_slots.append(ItemSlot.new())

##adds item to available emptyslot
#returns false if item cannot be added
func add_item(item : ItemData) -> bool:
	var slot = get_slot(item)
	if slot.quantity >= item.max_stack:
		slot = get_empty_slot()
		
		if(slot == null):
			return false
		
		slot.item = item
		slot.quantity = 1
	else:
		slot.quantity += 1
	
	return true

func remove_item(item : ItemData):
	pass

func get_item(slot : ItemSlot) -> ItemData:
	return null

func get_slot(item : ItemData) -> ItemSlot:
	return null

func get_empty_slot() -> ItemSlot:
	return null

func check_inventory(item : ItemData) -> bool:
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

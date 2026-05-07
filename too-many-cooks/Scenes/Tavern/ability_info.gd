extends VBoxContainer

#Class ID, which array elements to operate with.
var class_id : int = 0
#Ref array for ability displays.
var refs : Array[Control]
#Ref array for spell ability displays.
var spell_refs : Array[Control]
#ID for Spell ability to show.
var spell_id : int = 0

func _ready() -> void:
	refs = [
		$Atk,
		$Dash,
		$Spell1,
		$Spell2,
		$Spell3,
		$Spell4,
	]
	spell_refs = [
		$Spell1,
		$Spell2,
		$Spell3,
		$Spell4,
	]

func init_update(id: int, lv: int):
	class_id = id
	for r in refs:
		r.init_update(class_id, lv)

func update_abilities(lv: int):
	for r in refs:
		r.update_data(lv)

func _on_spell_back_button_down() -> void:
	cycle_spell(false)
func _on_spell_next_button_down() -> void:
	cycle_spell(true)

func cycle_spell(next: bool):
	for s in spell_refs:
		s.hide()
	var maxx : int = 2
	if class_id == 0 and PlayerStats.MeleeClassAbilityLevel >= 4:
		maxx = 3
	else:
		pass
	if next:
		spell_id += 1
		if spell_id > maxx:
			spell_id = 0
	else:
		spell_id -= 1
		if spell_id < 0:
			spell_id = maxx
	spell_refs[spell_id].show()

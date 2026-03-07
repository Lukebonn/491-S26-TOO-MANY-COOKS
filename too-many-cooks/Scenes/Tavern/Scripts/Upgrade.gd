class_name Upgrade extends TextureButton
#class for upgrades found in tavern. if you want to add one
#simply add a node type "upgrade"

#how much does the upgrade cost? for multiple expenses
#put multiple numbers
#then the corresponding cost for materials
@export var Cost_Amount : Array[int]
@export var Cost_Material : Array[int]
#Material index:
# 0 = gold
# 1 = logs
# 2 = stone

#rewards probably simple so like one stat boost/upgrade
#this reward will probably be decoded like
# index 0 = stat
# index 1 = amount boosted
# only index 0 used if its special though, so "Magic"
# is fed to something that understands that
@export var Upgrade_Reward : Array[String]

@export var Is_Complicated : bool
#for stat boosts
signal Upgrade_Basic(stat:String, boost:int)

#for more hard-codey solutions (like changing magic type) (IDK)
signal Upgrade_Complicated(variant:String)

func _ready():
	#hacky solution until we find a way to load certain things properly
	if PlayerStats.Magic == "Fireball" and name == "NPCMagic":
		hide()
	if PlayerStats.Magic == "Fireball" and name == "NPCEnd":
		show()
	self.connect("pressed",_on_upgrade)
	self.connect("mouse_entered",_on_mouse_entered)
	self.connect("mouse_exited",_on_mouse_exited)
	setup_label()
	
func _on_upgrade():
	print("Upgrading...")
	if check_cost(Cost_Amount,Cost_Material) == true:
		print("Upgrade successful, emitting signal and removing materials")
		if Is_Complicated:
			Upgrade_Complicated.emit(Upgrade_Reward[0])
		else:
			Upgrade_Basic.emit(Upgrade_Reward[0],Upgrade_Reward[1])
		queue_free()
	else:
		print("Upgrade failed")
		modulate = Color(1,0,0)
		await get_tree().create_timer(1).timeout
		modulate = Color(1,1,1)
func check_cost(CostNumberArray:Array,CostMaterialArray:Array):
	#var to reduce materials if upgrade is successful
	var gold_cost
	#var wood_cost
	#var stone_cost
	for mat_type in CostMaterialArray:
		match mat_type:
			0:
				if PlayerStats.Gold < CostNumberArray[mat_type]:
					return false
				else:
					gold_cost = 1
			1:
				pass
			2:
				pass
			_:
				return false
	
	PlayerStats.Gold -= gold_cost
	return true
	#PlayerStats.Wood -= wood_cost
	#PlayerStats.Stone -= stone_cost
	
func setup_label():
	#will need to be more complicated later to fit mulitple things
	var display_material : String
	match Cost_Material[0]:
		0:
			display_material = "Gold"
		1:
			display_material = "Wood"
		2: 
			display_material = "Stone"
	var ready_text = "Costs: " + str(Cost_Amount) + " " + display_material
	ready_text += "\n(You have " + str(PlayerStats.Gold) + ")"
	ready_text = ready_text.replace("\"","")
	ready_text = ready_text.replace("[","")
	ready_text = ready_text.replace("]","")
	$Panel/Label.text = ready_text	

func _on_mouse_entered():
	$Panel.show()
	setup_label()
func _on_mouse_exited():
	$Panel.hide()

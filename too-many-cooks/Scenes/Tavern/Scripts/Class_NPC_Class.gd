class_name Class_NPC extends TextureButton
#hook up to the player yuhh

@export_category("Class Menu Ref")
@export var Class_Menu_Ref : Control

#these change the class menu . 
#name is used to determine several things in class_menu node
@export_category("Class Info")
@export var Class_Name : String
@export var Class_Level : int

#these are the moves that will be grabbed if class is chosen
@export_category("Class Scripts")
@export var Class_Attack : Script
@export var Class_Dash : Script
@export var Class_Magic : Script

#these change the class menu
@export_category("Class Action Descs")
@export var Class_Attack_Desc: String
@export var Class_Dash_Desc : String
@export var Class_Magic_Desc : String
@export var Class_Other_Desc : String

#these become your stats LMAO!!!
@export_category("Class Stat Modifiers")
@export var Base_Strength : int
@export var Base_Max_Health : int
@export var Base_Max_Mana : int
#keep mana regen 0 on most classes since we get mana from swing
@export var Base_Mana_Regen : float
@export var Base_Defense : int
@export var Base_Speed : int

@export_category("Passive Stats")
@export var Passive_Strength : int
@export var Passive_Max_HP : int
@export var Passive_Max_Mana : int
@export var Passive_Defense : int
@export var Passive_Speed : int

#each level the class gets stronger by (level*base*modifier)
#this effects base and passive stats the same way
@export_category("Class Growth Modifier")
@export var Strength_Growth_Modifier : float
@export var Max_Health_Growth_Modifier : float
@export var Max_Mana_Growth_Modifier : float
#we aint ever using this one haha
@export var Mana_Regen_Growth_Modifier : float
@export var Defense_Growth_Modifier : float
@export var Speed_Growth_Modifier : float

#these are calcuated at runtime to sum up the class buffs
var new_str : float
var new_hp : float
var new_mana : float
var new_mana_regen : float
var new_def : float
var new_spd : float
#---
var new_passive_str : float
var new_passive_hp : float
var new_passive_mana : float
var new_passive_def : float
var new_passive_spd : float
#---
func _ready():
	self.connect("pressed",_on_clicked)
	self.connect("mouse_entered",_on_mouse_entered)
	self.connect("mouse_exited",_on_mouse_exited)
	self.modulate = Color(1,1,1)

func _on_mouse_entered():
	self.modulate = Color(1.25,1.25,1.25)
func _on_mouse_exited():
	self.modulate = Color(1,1,1)

func _on_clicked():	
	update_new_stats()
	if Class_Menu_Ref.is_showing == false:
		Class_Menu_Ref.set_title(Class_Name, Class_Level)
		Class_Menu_Ref.set_active_labels(new_str,new_hp,new_def,new_spd,new_mana)
		Class_Menu_Ref.set_passive_labels(new_passive_str,new_passive_hp,new_passive_def,new_passive_spd,new_passive_mana)
		Class_Menu_Ref.set_other_descriptions(Class_Attack_Desc,Class_Dash_Desc,Class_Magic_Desc,Class_Other_Desc)
		Class_Menu_Ref.show_menu()
func change_class(new_class: String):
	match new_class:
		"Warrior":
			PlayerStats.current_class = PlayerStats.classes.warrior
		"Rogue":
			PlayerStats.current_class = PlayerStats.classes.rogue
		"Mage":
			PlayerStats.current_class = PlayerStats.classes.mage
	#i do this later !!! :3
	
func update_sheet():
	update_new_stats()
	Class_Menu_Ref.set_title(Class_Name, Class_Level)
	Class_Menu_Ref.set_active_labels(new_str,new_hp,new_def,new_spd,new_mana)
	Class_Menu_Ref.set_passive_labels(new_passive_str,new_passive_hp,new_passive_def,new_passive_spd,new_passive_mana)
	Class_Menu_Ref.set_other_descriptions(Class_Attack_Desc,Class_Dash_Desc,Class_Magic_Desc,Class_Other_Desc)
		
func update_new_stats():
	new_str = Class_Level * Base_Strength * Strength_Growth_Modifier
	new_hp = Class_Level * Base_Max_Health * Max_Health_Growth_Modifier
	new_mana = Class_Level * Base_Max_Mana * Max_Mana_Growth_Modifier
	new_mana_regen = Class_Level * Base_Mana_Regen * Mana_Regen_Growth_Modifier
	new_def = Class_Level * Base_Defense * Defense_Growth_Modifier
	new_spd = Class_Level * Base_Speed * Speed_Growth_Modifier

	new_passive_str = Class_Level * Passive_Strength * Strength_Growth_Modifier
	new_passive_hp = Class_Level * Passive_Max_HP * Max_Health_Growth_Modifier
	new_passive_mana = Class_Level * Passive_Max_Mana * Max_Mana_Growth_Modifier
	new_passive_def = Class_Level * Passive_Defense * Defense_Growth_Modifier
	new_passive_spd = Class_Level * Passive_Speed * Speed_Growth_Modifier
	
	

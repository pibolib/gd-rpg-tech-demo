extends Node

var action_res = preload("res://scene/action/action.tres")

enum CHAR_ACTION {
	IDLE,
	WALK,
	ATTACK_EMPTY, #bare handed, gloves
	ATTACK_ONE_HAND_SWIPE, #equip with sword, axe, etc
	ATTACK_ONE_HAND_STAB, #equip with knife, rapier, etc
	ATTACK_TWO_HAND_SWIPE, #attack with two swords, axes, etc
	ATTACK_TWO_HAND_STAB, #attack with two knives, rapiers, etc
	ATTACK_BOTH_HAND_SWIPE, #attack with greatsword, warhammer, etc
	ATTACK_BOTH_HAND_STAB, #attack with spear, halberd, etc
	ATTACK_BOW, #attack using bow or similar drawing weapon
	ATTACK_ONE_HAND_GUN, #attack using pistol or similar weapon
	ATTACK_TWO_HAND_GUN, #attack using rifle or similar weapon
	SPECIAL_EMPTY, #charging special ability
	SPECIAL_ONE_HAND,
	SPECIAL_TWO_HAND,
	SPECIAL_BOTH_HAND,
	DAMAGE_LIGHT, #light damage reaction
	DAMAGE_HEAVY, #heavy damge reaction
	DEATH, #death animation
	ATTACK_MELEE,
	ATTACK_RANGED,
	ATTACK_MAGIC,
}

enum ITEM {
	NONE,
	HEALING_POTION,
	BRONZE_SWORD,
	OAKEN_BOW,
	IRON_STAFF,
	OAKEN_CLUB
}

enum ACTION {
	NONE,
	MELEE1,
	RANGED1,
	MAGIC1,
	FIRE1,
	ICE1,
	THUNDER1,
	HEAL1,
	ATKUP1,
	FIREMELEE1
}

var action_def = {
	"NAME": "",
	"ACTION_TYPE": "",
	"ACTION_SCRIPT": "",
	"ACTION_RANGE": 10,
	"ACTION_AP_COST": 1,
	"ACTION_POWER": 100,
	"ACTION_ICON": preload("res://assets/gfx/action/actionicons1.png"),
	"ACTION_USE_RULES": {}
}

var action_type = [
	"IDLE","WALK","ATTACK_EMPTY","ATTACK_ONE_HAND_SWIPE","ATTACK_ONE_HAND_STAB","ATTACK_TWO_HAND_SWIPE","ATTACK_TWO_HAND_STAB","ATTACK_BOTH_HAND_SWIPE","ATTACK_BOTH_HAND_STAB","ATTACK_BOW","ATTACK_ONE_HAND_GUN","ATTACK_TWO_HAND_GUN","SPECIAL_EMPTY","SPECIAL_ONE_HAND","SPECIAL_TWO_HAND","SPECIAL_BOTH_HAND","DAMAGE_LIGHT","DAMAGE_HEAVY","DEATH","ATTACK_MELEE","ATTACK_RANGED","ATTACK_MAGIC"
]

var action = [
	create_action("???",
	action_type[CHAR_ACTION.IDLE],
	"",
	10,
	1,
	"res://assets/gfx/action/actionicons1.png",
	{},
	-1),
	
	create_action("Attack I (Melee Weapon)", #name
	action_type[CHAR_ACTION.ATTACK_MELEE], #anim type
	"MeleeAttack1", #script
	10, #range
	1, #ap cost
	"res://assets/gfx/action/actionicons2.png", #icon
	{}, #usage rules or additional details
	100), #power 
	
	create_action("Attack I (Ranged Weapon)",
	action_type[CHAR_ACTION.ATTACK_RANGED],
	"RangedAttack1",
	100,
	1,
	"res://assets/gfx/action/actionicons5.png",
	{},
	100),
	
	create_action("Attack I (Magic Weapon)",
	action_type[CHAR_ACTION.ATTACK_MAGIC],
	"MagicAttack1",
	100,
	1,
	"res://assets/gfx/action/actionicons6.png",
	{},
	100),
	
	create_action("Fireball I",
	action_type[CHAR_ACTION.ATTACK_MAGIC],
	"",
	100,
	2,
	"res://assets/gfx/action/actionicons7.png",
	{},
	225),
	
	create_action("Iceshard I",
	action_type[CHAR_ACTION.ATTACK_MAGIC],
	"",
	100,
	2,
	"res://assets/gfx/action/actionicons8.png",
	{},
	225),
	
	create_action("Lightning I",
	action_type[CHAR_ACTION.ATTACK_MAGIC],
	"",
	100,
	2,
	"res://assets/gfx/action/actionicons9.png",
	{},
	225),
	
	create_action("Heal I",
	action_type[CHAR_ACTION.ATTACK_MAGIC],
	"",
	100,
	2,
	"res://assets/gfx/action/actionicons10.png",
	{},
	100),
	
	create_action("Attack Up I",
	action_type[CHAR_ACTION.ATTACK_MAGIC],
	"",
	100,
	2,
	"res://assets/gfx/action/actionicons11.png",
	{},
	0),
	
	create_action("Fire Blade I",
	action_type[CHAR_ACTION.ATTACK_MELEE],
	"",
	100,
	2,
	"res://assets/gfx/action/actionicons3.png",
	{},
	150)
]

var item_def = {
	"NAME": "",
	"SPRITE": preload("res://assets/gfx/item/itemicons1.png"),
	"TYPE": "ITEM",
	"DETAILS": {}
}

var items = [
	create_item_generic("???",
	"res://assets/gfx/item/itemicons1.png",
	{}),
	
	create_item_generic("Health Potion", 
	"res://assets/gfx/item/itemicons2.png", 
	{"ON_USE":""}),
	
	create_item_equip("Bronze Sword",
	"res://assets/gfx/item/itemicons3.png",
	"res://scene/charactermodel/EquipType/BronzeSword.tscn",
	"ONE",
	{"PhysAttack":3,"MagicAttack":-3}),
	
	create_item_equip("Oaken Bow",
	"res://assets/gfx/item/itemicons4.png",
	"res://scene/charactermodel/EquipType/OakenBow.tscn",
	"BOTH",
	{"PhysAttack":3}),
	
	create_item_equip("Iron Staff",
	"res://assets/gfx/item/itemicons5.png",
	"res://scene/charactermodel/EquipType/IronStaff.tscn",
	"ONE",
	{"PhysAttack":-3,"MagicAttack":3}),
	
	create_item_equip("Oaken Club",
	"res://assets/gfx/item/itemicons6.png",
	"res://scene/charactermodel/EquipType/WoodenClub.tscn",
	"ONE",
	{"PhysAttack":1,"MagicAttack":-10})
]

func create_action(name : String, anim : String, action_script : String, action_range : float, action_cost : float, action_icon : String, action_userule : Dictionary, action_power : int) -> Dictionary:
	var _action = action_def.duplicate(true)
	_action.NAME = name
	_action.ACTION_TYPE = anim
	_action.ACTION_SCRIPT = action_script
	_action.ACTION_RANGE = action_range
	_action.ACTION_ICON = load(action_icon)
	_action.ACTION_AP_COST = action_cost
	_action.ACTION_USE_RULE = action_userule
	_action.ACTION_POWER = action_power
	return _action

func create_item_generic(item_name : String, sprite : String, details : Dictionary) -> Dictionary:
	#name, sprite, details
	var _item = item_def.duplicate(true)
	_item.NAME = item_name
	_item.SPRITE = load(sprite)
	_item.DETAILS = details
	_item.TYPE = "ITEM"
	return _item

func create_item_equip(item_name : String, sprite : String, model : String, equip_type : String, modifiers : Dictionary, requirements : Dictionary = {}) -> Dictionary:
	#name, sprite, model, equip type, modifiers, requirements
	var _item = create_item_generic(item_name, sprite, {})
	_item.DETAILS = {
		"MODEL": load(model),
		"EQUIP_TYPE": equip_type, #OFF, MAIN, BOTH
		"MODIFIERS": modifiers,
		"REQUIREMENTS": requirements
	}
	_item.TYPE = "EQUIP"
	return _item

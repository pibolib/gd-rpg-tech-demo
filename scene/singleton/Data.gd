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

var action_type = [
	"IDLE","WALK","ATTACK_EMPTY","ATTACK_ONE_HAND_SWIPE","ATTACK_ONE_HAND_STAB","ATTACK_TWO_HAND_SWIPE","ATTACK_TWO_HAND_STAB","ATTACK_BOTH_HAND_SWIPE","ATTACK_BOTH_HAND_STAB","ATTACK_BOW","ATTACK_ONE_HAND_GUN","ATTACK_TWO_HAND_GUN","SPECIAL_EMPTY","SPECIAL_ONE_HAND","SPECIAL_TWO_HAND","SPECIAL_BOTH_HAND","DAMAGE_LIGHT","DAMAGE_HEAVY","DEATH","ATTACK_MELEE","ATTACK_RANGED","ATTACK_MAGIC"
]

var action = [
	create_action("Attack (Melee Weapon)",action_type[CHAR_ACTION.ATTACK_MELEE],"",10,1,"res://assets/gfx/action/actionicons2.png",{})
]

func create_action(name : String, anim : String, action_script : String, action_range : float, action_cost : float, action_icon : String, action_userule : Dictionary) -> Resource:
	var my_action = action_res.new()
	my_action.name = name
	my_action.effect_script = load(action_script)
	my_action.target_radius = action_range
	my_action.action_point_cost = action_cost
	my_action.icon = load(action_icon)
	my_action.userule = action_userule
	return my_action

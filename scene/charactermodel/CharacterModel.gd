extends "res://scene/3dobj/3dobj.gd"

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
}

var state = "IDLE"

func get_current_anim_pos(): #returns current animation time position
	return $AnimationHandler.current_animation_position
	
func get_state(): #returns current animation state
	return state

func set_state(st):
	state = st

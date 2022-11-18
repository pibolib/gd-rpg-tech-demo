extends "res://scene/3dobj/3dobj.gd"



var state = "IDLE"

func get_current_anim_pos(): #returns current animation time position
	return $AnimationHandler.current_animation_position
	
func get_state() -> String: #returns current animation state
	return state

func set_state(st : String) -> void:
	state = st

func equip_main(item : Dictionary) -> void: #generic equip function
	pass

func equip_off(item : Dictionary) -> void: #generic equip function
	pass

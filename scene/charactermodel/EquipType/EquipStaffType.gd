extends "res://scene/charactermodel/EquipGeneric.gd"

func hand_scale(dir : float, anim : String) -> Vector2:
	var scl = Vector2(1,1)
	match anim:
		"WALK", "IDLE":
			scl = .hand_scale(dir, anim)
		"ATTACK_MAGIC":
			scl = .hand_scale(dir, anim)
	scl.x *= -1
	return scl

func sprite_orientation(_dir : float, anim : String) -> void:
	match anim:
		_:
			rotation = -PI/2

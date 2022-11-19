extends Sprite
#generic equipment/hand rotation system  (this works already for swords)


func hand_scale(dir : float, anim : String) -> Vector2:
	var scl = Vector2(1,1)
	match anim:
		_:
			if dir <= PI:
				scl = Vector2(1,-1)
			else:
				scl = Vector2(-1,-1)
	return scl

func sprite_orientation(dir : float, anim : String) -> void:
	match anim:
		_:
			rotation = dir
			scale.x = 1 - abs(sin(dir))*0.25

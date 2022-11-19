extends "res://scene/charactermodel/EquipGeneric.gd"

export(PoolVector2Array) var frames = PoolVector2Array()
export(PoolVector2Array) var offsets = PoolVector2Array()
export(Vector2) var frame_size = Vector2(8,8)

func _ready():
	region_enabled = true
	region_rect.position = Vector2(0,0)
	region_rect.size = frame_size

func hand_scale(dir : float, anim : String) -> Vector2:
	var scl = Vector2(1,1)
	match anim:
		"WALK", "IDLE":
			scl = .hand_scale(dir, anim)
		"ATTACK_BOW":
			pass
	return scl

func sprite_orientation(dir : float, anim : String) -> void:
	var anim_frame = 0
	match anim:
		"WALK", "IDLE":
			anim_frame = get_sprite_facing_4dir(dir+PI/4)
			if anim_frame % 2 == 0:
				rotation = PI/2
			else:
				rotation = dir + PI/2
			anim_frame = anim_frame % 2
	offset = offsets[anim_frame]
	region_rect.position = frames[anim_frame]
	

func get_sprite_facing_4dir(angle : float) -> int: #returns a sprite index for a body part with four directions.
	var spr
	angle = wrapf(angle,0,2*PI)
	if angle <= PI/2:
		spr = 0
	elif angle > PI/2 and angle <= PI:
		spr = 1
	elif angle > PI and angle <= 3*PI/2:
		spr = 2
	else:
		spr = 3
	return spr

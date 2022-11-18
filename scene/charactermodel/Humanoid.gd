extends "res://scene/charactermodel/CharacterModel.gd"

var torso_offset = 12
var equip_left = {}
var equip_right = {}

func _ready():
	$AnimationHandler.play(state)

# warning-ignore:unused_argument
func _process(delta):
	position.y = z
	#set base positions. if state is "IDLE", this is the entire action.
	$Torso.position.y = -torso_offset
	set_limb_pos($Legs/Foot1,dir,4,PI/2)
	set_limb_pos($Legs/Foot2,dir,4,3*PI/2)
	set_limb_pos($Torso/Arm/Hand1,dir,6,PI/2)
	set_limb_pos($Torso/Arm/Hand2,dir,6,3*PI/2)
	set_torso_sprite(dir)
	set_leg_sprite(dir)
	set_hand_sprite(dir)
	set_head_sprite(dir)
	#update_equip(dir)
	handle_state()
	update_z()

func set_torso_sprite(angle : float) -> void: #sets torso sprite based on angle
	var angle_sprites = [
		Vector2(0,24),
		Vector2(8,24)
	]
	angle = wrap_angle(angle)
	var spr = get_sprite_facing_2dir(angle)
	$Torso.region_rect.position = angle_sprites[spr]

func set_head_sprite(angle : float) -> void:
	var angle_sprites = [
		Vector2(0,0),
		Vector2(10,0),
		Vector2(20,0),
		Vector2(30,0)
	]
	var angle_sprites2 = [
		Vector2(0,11),
		Vector2(15,11),
		Vector2(30,11),
		Vector2(45,11)
	]
	var spr = get_sprite_facing_4dir(angle)
	$Torso/Head.region_rect.position = angle_sprites[spr]
	$Torso/Head/Hair.region_rect.position = angle_sprites2[spr]
	if spr == 1 or spr == 2 or spr == 3:
		$Torso/Head.offset.x = 1
		$Torso/Head/Hair.offset.x = 0.5
	else:
		$Torso/Head.offset.x = 0
		$Torso/Head/Hair.offset.x = -0.5

func set_leg_sprite(angle : float) -> void: #sets leg sprite based on angle
	var angle_sprites = [
		Vector2(0,35),
		Vector2(6,35),
		Vector2(12,35),
		Vector2(18,35)
	]
	var spr = get_sprite_facing_4dir(angle+PI/4)
	$Legs/Foot1.region_rect.position = angle_sprites[spr]
	$Legs/Foot2.region_rect.position = angle_sprites[spr]

func set_limb_pos(node : Node, angle : float, dist : float, offset : float) -> void: #generically sets position based on angle, dist, and offset, works for any Node2D
	node.position = trig_pos(angle,dist,offset)
	
func set_hand_sprite(angle : float) -> void: #sets hand flip based on angle
	var spr = get_sprite_facing_2dir(angle+PI/2)
	if spr == 0:
		$Torso/Arm/Hand1.scale.x = 1
		$Torso/Arm/Hand2.scale.x = 1
	else:
		$Torso/Arm/Hand1.scale.x = -1
		$Torso/Arm/Hand2.scale.x = -1

func wrap_angle(angle : float) -> float: #returns an angle wrapped between 0 and 2*PI.
	return wrapf(angle, 0, 2*PI)

func get_sprite_facing_4dir(angle : float) -> int: #returns a sprite index for a body part with four directions.
	var spr
	angle = wrap_angle(angle)
	if angle <= PI/2:
		spr = 0
	elif angle > PI/2 and angle <= PI:
		spr = 1
	elif angle > PI and angle <= 3*PI/2:
		spr = 2
	else:
		spr = 3
	return spr

func get_sprite_facing_2dir(angle : float) -> int: #returns a sprite index for a body part with two directions.
	var spr
	angle = wrap_angle(angle)
	if angle <= PI:
		spr = 0
	else:
		spr = 1
	return spr

func trig_pos(angle : float, dist : float, mod : float = 0) -> Vector2: #returns a vector2 position given an angle and a distance. also allows for a modifier to the angle.
	return Vector2(cos(angle+mod)*dist,sin(angle+mod)*dist/2)

func update_z() -> void: #updates z_index for all limbs which rotate around main character.
	var limbs = [
		$Torso/Arm/Hand1, $Torso/Arm/Hand2, $Legs/Foot1, $Legs/Foot2
	]
	for limb in limbs:
		limb.z_index = limb.position.y

func walk(time : float) -> void: #this animation lasts for one second and covers a few footsteps.
	var tangent = Vector2(cos(dir),sin(dir)*0.5)
	$Legs/Foot1.position += tangent * sin(2*time*PI) * 6
	$Legs/Foot2.position += tangent * sin(2*time*PI+PI) * 6
	$Torso/Arm/Hand1.position += tangent * sin(2*time*PI+PI) * 2
	$Torso/Arm/Hand2.position += tangent * sin(2*time*PI) * 2
	$Torso/Arm/Hand1.position.y += abs(sin(2*PI*time))
	$Torso/Arm/Hand2.position.y += abs(sin(2*PI*time+PI))
	#update_equip(dir)

func attack_one_hand_swipe(time : float) -> void: #this animation lasts for 0.5 seconds.
	var tangent = Vector2(cos(dir),sin(dir)*0.5)
	$Legs/Foot1.position += tangent * sin(-1) * 6
	$Legs/Foot2.position += tangent * sin(1) * 6
	$Torso/Arm/Hand2.position += tangent * sin(-1-time) * 2
	set_limb_pos($Torso/Arm/Hand1,dir-time*8,8,PI/2)
	#update_equip(dir-time*4+PI/4)

func handle_state() -> void: #handles calls for animation state
	match state:
		"WALK":
			walk($AnimationHandler.current_animation_position)
		"ATTACK_ONE_HAND_SWIPE":
			attack_one_hand_swipe($AnimationHandler.current_animation_position)

func _on_AnimationHandler_animation_finished(anim_name : String) -> void: #this function will be pretty large.
	match anim_name:
		"WALK":
			state = "IDLE"
		"ATTACK_ONE_HAND_SWIPE":
			state = "ATTACK_ONE_HAND_SWIPE"
	$AnimationHandler.play()

#func update_equip(angle : float, limb : int = 0) -> void: #updates equipment positioning given angle
#	if equip_left != -1 and limb == 0:
#		if $Torso/Arm/Hand1.scale.x == 1:
#			$Torso/Arm/Hand1/Equip.rotation = -angle
#		else:
#			$Torso/Arm/Hand1/Equip.rotation = angle + PI
#		$Torso/Arm/Hand1/Equip.scale = Vector2(1-(cos(angle)+1)/8,1)

func equip_main(item : Dictionary) -> void:
	$Torso/Arm/Hand1/Equip.queue_free()
	var new_model = item.DETAILS.MODEL.instance()
	new_model.set_name("Equip")
	$Torso/Arm/Hand1.add_child(new_model)

func equip_off(item : Dictionary) -> void:
	$Torso/Arm/Hand2/Equip.queue_free()
	var new_model = item.DETAILS.MODEL.instance()
	new_model.set_name("Equip")
	$Torso/Arm/Hand2.add_child(new_model)

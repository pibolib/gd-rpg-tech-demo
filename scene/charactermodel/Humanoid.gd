extends Node2D

# absolute law: vertical axis is 1/2 horizontal.
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

var dir = 0
var torso_offset = 12
var move = true
var state = CHAR_ACTION.IDLE

func _ready():
	pass

func _input(event): #debug rotate pause
	if event.is_action_pressed("ui_accept"):
		move = !move

func _process(delta):
	if move: dir += delta
	#set base positions. if state is CHAR_ACTION.IDLE, this is the final position for this frame.
	$Torso.position.y = -torso_offset
	set_limb_pos($Legs/Foot1,dir,4,PI/2)
	set_limb_pos($Legs/Foot2,dir,4,3*PI/2)
	set_limb_pos($Torso/Arm/Hand1,dir,6,PI/2)
	set_limb_pos($Torso/Arm/Hand2,dir,6,3*PI/2)
	set_torso_sprite(dir)
	set_leg_sprite(dir)
	set_hand_sprite(dir)
	set_head_sprite(dir)

func set_torso_sprite(angle): #sets torso sprite based on angle
	var angle_sprites = [
		Vector2(0,20),
		Vector2(7,20)
	]
	angle = wrap_angle(angle)
	var spr = get_sprite_facing_2dir(angle)
	$Torso.region_rect.position = angle_sprites[spr]

func set_head_sprite(angle):
	var angle_sprites = [
		Vector2(0,0),
		Vector2(8,0),
		Vector2(16,0),
		Vector2(24,0)
	]
	var angle_sprites2 = [
		Vector2(0,9),
		Vector2(13,9),
		Vector2(26,9),
		Vector2(39,9)
	]
	var spr = get_sprite_facing_4dir(angle)
	$Torso/Head.region_rect.position = angle_sprites[spr]
	$Torso/Head/Hair.region_rect.position = angle_sprites2[spr]
	if spr == 1 or spr == 2:
		$Torso/Head.offset.x = 1.5
		$Torso/Head/Hair.offset.x = 0.5
	else:
		$Torso/Head.offset.x = 0.5
		$Torso/Head/Hair.offset.x = -0.5

func set_leg_sprite(angle): #sets leg sprite based on angle
	var angle_sprites = [
		Vector2(0,29),
		Vector2(4,29),
		Vector2(8,29),
		Vector2(12,29)
	]
	var spr = get_sprite_facing_4dir(angle)
	$Legs/Foot1.region_rect.position = angle_sprites[spr]
	$Legs/Foot2.region_rect.position = angle_sprites[spr]

func set_limb_pos(node, angle, dist, offset): #generically sets position based on angle, dist, and offset, works for any Node2D
	node.position = trig_pos(angle,dist,offset)
	node.z_index = node.position.y
	
func set_hand_sprite(angle): #sets hand flip based on angle
	var spr = get_sprite_facing_2dir(angle+PI/2)
	$Torso/Arm/Hand1.flip_v = spr
	$Torso/Arm/Hand2.flip_v = spr

func wrap_angle(angle): #returns an angle wrapped between 0 and 2*PI.
	return wrapf(angle, 0, 2*PI)

func get_sprite_facing_4dir(angle): #returns a sprite index for a body part with four directions.
	var spr
	angle = wrap_angle(angle)
	if angle <= PI/4 or angle >= 7*PI/4:
		spr = 0
	elif angle > PI/4 and angle <= 3*PI/4:
		spr = 1
	elif angle > 3*PI/4 and angle <= 5*PI/4:
		spr = 2
	else:
		spr = 3
	return spr

func get_sprite_facing_2dir(angle): #returns a sprite index for a body part with two directions.
	var spr
	angle = wrap_angle(angle)
	if angle >= 7*PI/4 or angle <= 3*PI/4:
		spr = 0
	else:
		spr = 1
	return spr

func trig_pos(angle, dist, mod=0): #returns a vector2 position given an angle and a distance. also allows for a modifier to the angle.
	return Vector2(cos(angle+mod)*dist,sin(angle+mod)*dist/2)

func _on_AnimationHandler_animation_finished(anim_name): #this function will be pretty large.
	pass # Replace with function body.

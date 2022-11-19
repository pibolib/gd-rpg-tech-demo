extends KinematicBody2D
class_name Character

var action_scene = preload("res://scene/action/Action.tscn")

#gameplay variables **NOT STATS**
export var team = 0 #0: player, 1: enemy, 2: neutral (unimplemented)
var dir = 0

signal cancel_action

var stats = {
	"CharAttributes": {
		"Strength": 10,
		"Constitution": 10,
		"Intelligence": 10,
		"Wisdom": 10,
		"Charisma": 10,
		"Dexterity": 10
	},
	"EquipAttributes": {
		"Main": {},
		"Off": {}
	},
	"CombatStats": {
		"PhysAttack": 10,
		"MagicAttack": 10,
		"PhysDefense": 10,
		"MagicDefense": 10,
		"HP": 100,
		"MaxHP": 100,
		"AP": 3,
		"MaxAP": 3
	},
	"EquippedActions": {
		"PrimaryAttack": Data.action[Data.ACTION.RANGED1],
		"SecondaryAttack": Data.action[Data.ACTION.NONE],
		"PrimarySupport": Data.action[Data.ACTION.NONE],
		"SecondarySupport": Data.action[Data.ACTION.NONE]
	}
} #generic stats, get these from somewhere else (copied or referenced)
var action = Data.action[Data.ACTION.NONE]
var cancancelaction = true
var actionactive = false
export var speed = 80
export var gravity = 0
var vel = Vector2(0,0)
var target = Vector2(0,0)
var attacktarget = Vector2(0,0)
var min_range = 10
var invul = false

func _ready():
	target = position
	$Model.set_gravity(gravity)

func _physics_process(delta):
	if position.distance_to(target) > min_range:
		var target_angle = position.angle_to_point(target)+PI
		model_facing(lerp_angle($Model.get_dir(),target_angle,8*delta))
		dir = $Model.get_dir()
		vel = Vector2(cos($Model.get_dir()),sin($Model.get_dir())) * speed
		set_anim("WALK")
	else:
		if action.hash() == Data.action[Data.ACTION.NONE].hash():
			set_anim("IDLE")
		elif !actionactive:
			var target_angle = position.angle_to_point(attacktarget)+PI
			model_facing(target_angle)
			dir = $Model.get_dir()
			create_action(action)
			actionactive = true
		target = position
		vel = Vector2(0,0)
	vel = move_and_slide(vel)

func navigate(tar : Vector2, moveonly : bool=false) -> void:
	if cancancelaction:
		target = tar
		if !moveonly:
			emit_signal("cancel_action")
		else:
			min_range = 10

func model_facing(angle : float) -> void:
	$Model.set_dir(angle)

func add_damage(value : float) -> void:
	if !invul:
		stats.CombatStats.HP -= value
		start_invul()

func start_invul() -> void:
	invul = true
	$Invulnerability.start(1)

func _on_Invulnerability_timeout() -> void:
	invul = false
	$Invulnerability.stop()

func action_attack_main(pos : Vector2) -> void:
	if cancancelaction:
		navigate(pos)
		attacktarget = pos
		min_range = stats.EquippedActions.PrimaryAttack.ACTION_RANGE
		action = stats.EquippedActions.PrimaryAttack
		emit_signal("cancel_action")

func action_attack_sub(pos : Vector2) -> void:
	if cancancelaction:
		navigate(pos)
		attacktarget = pos
		min_range = stats.EquippedActions.SecondaryAttack.ACTION_RANGE
		action = stats.EquippedActions.SecondaryAttack
		emit_signal("cancel_action")

func action_support_main(pos : Vector2) -> void:
	if cancancelaction:
		navigate(pos)
		attacktarget = pos
		min_range = stats.EquippedActions.PrimarySupport.ACTION_RANGE
		action = stats.EquippedActions.PrimarySupport
		emit_signal("cancel_action")

func action_support_sub(pos : Vector2) -> void:
	if cancancelaction:
		navigate(pos)
		attacktarget = pos
		min_range = stats.EquippedActions.SecondarySupport.ACTION_RANGE
		action = stats.EquippedActions.SecondarySupport
		emit_signal("cancel_action")

func create_action(action : Dictionary) -> void:
	var new_action = action_scene.instance()
	new_action.action_animation = action.ACTION_SCRIPT
	new_action.userstats = stats
	new_action.dir = dir
	new_action.target = attacktarget
	add_child(new_action)

func set_anim(anim : String) -> void:
	$Model.set_state(anim)

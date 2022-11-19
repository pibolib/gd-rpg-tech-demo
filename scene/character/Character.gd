extends KinematicBody2D
class_name Character

#gameplay variables **NOT STATS**
export var team = 0 #0: player, 1: enemy, 2: neutral (unimplemented)

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
		"MaxHP": 100
	},
	"EquippedActions": {
		"PrimaryAttack": Data.action[Data.ACTION.NONE],
		"SecondaryAttack": Data.action[Data.ACTION.NONE],
		"PrimarySupport": Data.action[Data.ACTION.NONE],
		"SecondarySupport": Data.action[Data.ACTION.NONE]
	}
} #generic stats, get these from somewhere else (copied or referenced)
var action = Data.action[Data.ACTION.NONE]
export var speed = 80
export var gravity = 0
var vel = Vector2(0,0)
var target = Vector2(0,0)
var min_range = 10
var invul = false

func _ready():
	target = position
	$Model.set_gravity(gravity)

#func _input(event):
#	if event.is_action_pressed("ui_rc"):
#		navigate(get_global_mouse_position())

func _physics_process(delta):
	if position.distance_to(target) > min_range:
		var target_angle = position.angle_to_point(target)+PI
		model_facing(lerp_angle($Model.get_dir(),target_angle,8*delta))
		vel = Vector2(cos($Model.get_dir()),sin($Model.get_dir())) * speed
		#model_facing(PI+position.angle_to_point(target))
		$Model.set_state("WALK")
	else:
		$Model.set_state("IDLE")
		target = position
		vel = Vector2(0,0)
	vel = move_and_slide(vel)

func navigate(tar : Vector2, mr : float = 10) -> void:
	target = tar
	min_range = mr

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

func action_attack_main(position : Vector2) -> void:
	navigate(position)
	min_range = stats.EquippedActions.PrimaryAttack.ACTION_RANGE
	action = stats.EquippedActions.PrimaryAttack

func action_attack_sub(_position : Vector2) -> void:
	navigate(position)
	min_range = stats.EquippedActions.SecondaryAttack.ACTION_RANGE
	action = stats.EquippedActions.SecondaryAttack

func action_support_main(_position : Vector2) -> void:
	navigate(position)
	min_range = stats.EquippedActions.PrimarySupport.ACTION_RANGE
	action = stats.EquippedActions.PrimarySupport

func action_support_sub(_position : Vector2) -> void:
	navigate(position)
	min_range = stats.EquippedActions.SecondarySupport.ACTION_RANGE
	action = stats.EquippedActions.SecondarySupport

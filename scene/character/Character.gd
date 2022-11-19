extends KinematicBody2D

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
} #generic stats, get these from somewhere else (copied or referenced)
var action = ""
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

extends KinematicBody2D

var action = ""
export var speed = 80
export var gravity = 0
var vel = Vector2(0,0)
var target = Vector2(0,0)
var min_range = 10

func _ready():
	target = position
	$Model.set_gravity(gravity)

func _input(event):
	if event.is_action_pressed("ui_rc"):
		navigate(get_global_mouse_position())

func _physics_process(delta):
	if position.distance_to(target) > min_range:
		var target_angle = position.angle_to_point(target)+PI
		model_facing(lerp_angle($Model.get_dir(),target_angle,4*delta))
		vel = Vector2(cos($Model.get_dir()),sin($Model.get_dir())) * speed
		#model_facing(PI+position.angle_to_point(target))
		$Model.set_state("WALK")
	else:
		$Model.set_state("IDLE")
	vel = move_and_slide(vel)
	vel *= 0.2

func navigate(tar, mr=10):
	target = tar
	min_range = mr

func model_facing(angle):
	$Model.set_dir(angle)

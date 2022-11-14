extends KinematicBody2D

var action = ""
var speed = 80
var vel = Vector2(0,0)
var target = Vector2(0,0)
var min_range = 10
export var gravity = 0

func _ready():
	target = position
	$Model.set_gravity(gravity)

func _input(event):
	if event.is_action_pressed("ui_lc"):
		model_facing(get_global_mouse_position().angle_to_point(position))
	if event.is_action_pressed("ui_rc"):
		navigate(get_global_mouse_position())

func _physics_process(delta):
	if position.distance_to(target) > min_range:
		vel = Vector2(cos(position.angle_to_point(target)),sin(position.angle_to_point(target))) * -speed
		model_facing(PI+position.angle_to_point(target))
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

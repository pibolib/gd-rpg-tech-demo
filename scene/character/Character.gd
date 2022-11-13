extends KinematicBody2D

var action = "IDLE"
var speed = 300
var vel = Vector2(0,0)
onready var nav_agent = $NavigationAgent2D

func _ready():
	nav_agent.avoidance_enabled = true
	var desired_distance = floor(speed/100)
	nav_agent.path_desired_distance = desired_distance
	nav_agent.target_desired_distance = desired_distance
	nav_agent.set_target_location(position)

func _input(event):
	if event.is_action_pressed("ui_lc"):
		model_facing(get_global_mouse_position().angle_to_point(position))
	if event.is_action_pressed("ui_rc"):
		navigate(get_global_mouse_position())

func _physics_process(delta):
	if !nav_agent.is_navigation_finished():
		var target = nav_agent.get_next_location()
		var angle_to_target = position.angle_to_point(target)
		vel = Vector2(cos(angle_to_target),sin(angle_to_target)) * speed
		model_facing(target.angle_to_point(position))
	vel = move_and_slide(vel)

func navigate(target):
	nav_agent.set_target_location(target)
	print(nav_agent.get_next_location())

func model_facing(angle):
	$Model.set_dir(angle)

#MALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALDMALD

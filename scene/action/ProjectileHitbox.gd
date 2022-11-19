extends KinematicBody2D

var z = 0
var dir = 0
var gravity = 0
var zvel = 0
var target = Vector2(0,0)
var vel = Vector2(0,0)
var speed = 200
var team = 0
var damage = 4
var sprite = ""

func _ready():
	vel = Vector2(cos(dir),sin(dir)) * speed
	$Timer.start(5)
	$Sprite.texture = load(sprite)
	$Sprite.rotation = dir
	$Sprite.position.y = -z

func get_dir():
	return dir

func set_dir(angle):
	dir = wrapf(angle,0,2*PI)

func _process(delta):
	z += zvel * delta
	zvel += gravity
	if z >= 0:
		z = 0
		zvel = 0
func _physics_process(_delta):
	vel = move_and_slide(vel)

func set_zvel(velo):
	zvel = velo

func set_gravity(g):
	gravity = g

func mod_dir(angle):
	dir = wrapf(dir+angle,0,2*PI)

func _on_Timer_timeout():
	queue_free()

func kill():
	queue_free()

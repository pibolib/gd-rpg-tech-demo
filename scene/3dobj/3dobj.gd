extends Node2D

var z = 0
var dir = 0
var gravity = 0
var zvel = 0

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

func set_zvel(vel):
	zvel = vel

func set_gravity(g):
	gravity = g

func mod_dir(angle):
	dir = wrapf(dir+angle,0,2*PI)

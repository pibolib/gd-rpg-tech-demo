extends Node2D

var z = 0
var dir = 0
var gravity = 0
var zvel = 0

func set_dir(angle):
	dir = angle

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

extends Area2D

var damage = 4
var team = 0

func kill() -> void:
	queue_free()

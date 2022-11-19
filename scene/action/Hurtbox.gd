extends Area2D

onready var damage = get_parent().damage
onready var team = get_parent().team

func kill():
	get_parent().kill()

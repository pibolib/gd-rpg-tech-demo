extends Node2D

var select_start = Vector2(0,0)
var select_end = Vector2(0,0)
var select_draw = false
var shift = false

func _process(_delta):
	shift = Input.is_action_pressed("ui_sub")

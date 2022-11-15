extends Node2D

var select_start = Vector2(0,0)
var select_end = Vector2(0,0)
var select_draw = false

#func _process(delta):
#	if Input.is_action_just_pressed("ui_lc"):
#		select_start = get_global_mouse_position()
#		select_draw = true
#	if Input.is_action_pressed("ui_lc"):
#		select_end = get_global_mouse_position()
#	if Input.is_action_just_released("ui_lc"):
#		select_draw = false
#	if select_start.distance_to(select_end) > 3:
#		$NinePatchRect.rect_size = abs(select_start-select_end)
#		$NinePatchRect.rect_position = select_start

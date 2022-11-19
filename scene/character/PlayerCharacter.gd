extends "res://scene/character/Character.gd"

func _ready():
	add_to_group("Player")
	$Model.equip_left = $Model.equip_main(Data.items[Data.ITEM.BRONZE_SWORD])

func _input(event):
	if event.is_action_pressed("ui_rc"):
		navigate(get_global_mouse_position())

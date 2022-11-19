extends "res://scene/character/Character.gd"
class_name PlayerCharacter

var selected = false

func _ready():
	add_to_group("Player")
	$Model.equip_left = $Model.equip_main(Data.items[Data.ITEM.OAKEN_BOW])

func _unhandled_input(event):
	if event.is_action_pressed("ui_rc") and selected:
		navigate(get_global_mouse_position(), true)
	if event.is_action_pressed("ui_lc") and selected:
		deselect()

func deselect() -> void:
	selected = false

func select() -> void:
	selected = true

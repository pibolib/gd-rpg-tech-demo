extends "res://scene/character/Character.gd"
class_name PlayerCharacter

var selected = false

func _ready():
	add_to_group("Player")
	$Model.equip_left = $Model.equip_main(Data.items[Data.ITEM.BRONZE_SWORD])

func _input(event):
	if selected:
		if event.is_action_pressed("ui_rc"):
			navigate(get_global_mouse_position())

func deselect() -> void:
	selected = false

func select() -> void:
	selected = true

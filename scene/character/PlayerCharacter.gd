extends "res://scene/character/Character.gd"
class_name PlayerCharacter

var selected = false
var current_class = 0

func _ready():
	add_to_group("Player")
	$Model.equip_left = $Model.equip_main(Data.items[Data.ITEM.OAKEN_BOW])

func _unhandled_input(event):
	if event.is_action_pressed("ui_rc") and selected:
		navigate(get_global_mouse_position(), true)
	if event.is_action_pressed("ui_lc") and selected:
		deselect()
	if event.is_action_pressed("ui_select"):
		match current_class:
			0:
				$Model.equip_left = $Model.equip_main(Data.items[Data.ITEM.OAKEN_BOW])
				stats.EquippedActions.PrimaryAttack = Data.action[Data.ACTION.RANGED1]
			1:
				$Model.equip_left = $Model.equip_main(Data.items[Data.ITEM.IRON_STAFF])
				stats.EquippedActions.PrimaryAttack = Data.action[Data.ACTION.MAGIC1]
			2:
				$Model.equip_left = $Model.equip_main(Data.items[Data.ITEM.BRONZE_SWORD])
				stats.EquippedActions.PrimaryAttack = Data.action[Data.ACTION.MELEE1]
		current_class += 1
		current_class = current_class % 3

func deselect() -> void:
	selected = false

func select() -> void:
	selected = true

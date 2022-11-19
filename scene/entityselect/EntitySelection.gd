extends Area2D

export(int, "PLAYER", "ENEMY", "NEUTRAL") var team = 0


func _on_EntitySelection_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_rc"):
		if team == 1:
			if !MouseHandler.shift:
				get_tree().call_group("Player","action_attack_main",position)
			else:
				get_tree().call_group("Player","action_attack_sub",position)
		elif team == 0:
			if !MouseHandler.shift:
				get_tree().call_group("Player","action_support_main",position)
			else:
				get_tree().call_group("Player","action_support_sub",position)
	if event.is_action_pressed("ui_lc"):
		if team == 0:
			get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Player","deselect")
			get_parent().select()

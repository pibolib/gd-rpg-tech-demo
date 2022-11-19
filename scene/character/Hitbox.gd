extends Area2D

onready var team = get_parent().team

func _on_Hitbox_area_entered(area : Area2D) -> void:
	if area.name == "Hurtbox" and area.get_parent() is Character:
		if area.team != team:
			get_parent().add_damage(area.damage)
			area.kill()

extends Node2D

var hurtbox = preload("res://scene/action/Hurtbox.tscn")
var projectile = preload("res://scene/action/ProjectileHurtbox.tscn")

var target = Vector2(0,0)
var action = Data.action[Data.ACTION.NONE]
var userstats = {}
var damage = 0
onready var dir = get_parent().dir
onready var team = get_parent().team
var action_animation = ""

func _ready():
	$Sprite.texture = action.ACTION_ICON
	get_parent().connect("cancel_action", self, "_on_cancel_action")
	$ActionAnimation.play(action_animation)
	damage = 10

func _on_ActionAnimation_animation_finished(_anim_name):
	get_parent().actionactive = false
	get_parent().action = Data.action[Data.ACTION.NONE]
	queue_free()

func remove_ap() -> void:
	userstats.CombatStats.AP -= action.ACTION_AP_COST

func set_player_anim(anim : String) -> void:
	get_parent().set_anim(anim)

func _on_cancel_action():
	get_parent().cancancelaction = true
	get_parent().actionactive = false
	queue_free()

func toggle_cancel() -> void:
	get_parent().cancancelaction = !get_parent().cancancelaction

func create_hurtbox_local(relative_pos : Vector2, size : Vector2) -> void:
	var new_hurtbox = hurtbox.instance()
	new_hurtbox.position = relative_pos
	new_hurtbox.scale = size
	new_hurtbox.damage = damage
	new_hurtbox.team = team
	get_parent().add_child(new_hurtbox)

func create_hurtbox_dir_offset(offset : float, size : Vector2) -> void:
	var relative_pos = Vector2(cos(dir), sin(dir)/2) * -offset
	create_hurtbox_local(relative_pos, size)

func create_hurtbox_global(pos : Vector2=target, size : Vector2=Vector2(16,8)) -> void:
	var new_hurtbox = hurtbox.instance()
	new_hurtbox.position = pos
	new_hurtbox.scale = size
	new_hurtbox.damage = damage
	new_hurtbox.team = team
	get_parent().get_parent().add_child(new_hurtbox)

func create_hurtbox_projectile(relative_pos : Vector2, _size : Vector2, sprite : String, z : float=16.0) -> void:
	var new_projectile = projectile.instance()
	new_projectile.z = z
	new_projectile.sprite = sprite
	new_projectile.position = get_parent().position + relative_pos
	new_projectile.dir = dir
	new_projectile.team = team
	get_parent().get_parent().add_child(new_projectile)

func create_instance(path : String, _pos : Vector2, local : bool=false) -> void:
	var inst = load(path).instance()
	inst.position = target
	if local:
		get_parent().add_child(inst)
	else:
		get_parent().get_parent().add_child(inst)
	

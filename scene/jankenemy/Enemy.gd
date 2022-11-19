extends Character

var shake = 0

func _ready():
	team = 1
	$Hitbox.team = team

func _process(delta):
	shake -= 16*delta
	$Sprite.offset.x = rand_range(-shake,shake)
	shake = clamp(shake,0,20)

func add_damage(damage):
	shake += damage

extends Particles2D

func _ready():
	emitting = true
	$Timer.start(2)

func _on_Timer_timeout():
	queue_free()

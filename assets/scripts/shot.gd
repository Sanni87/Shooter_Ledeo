extends Area2D

const SPEED = 296

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x += SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		queue_free()

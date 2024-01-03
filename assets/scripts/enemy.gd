extends Node2D

const SPEED = 60

@onready var explotion : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match explotion:
		false: global_position.x -= SPEED * delta
		
func explotion_ctrl() -> void:
	explotion = true
	$Area2D.queue_free()
	$Explotion.play("Explotion")
	$Explotion/Audio.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func _on_area_2d_body_entered(body):
	if body is Player: # recordamos que el player es de una clase propia llamada Player
		explotion_ctrl()
		body.queue_free()
		GLOBAL.credits -= 1
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("Shot"):
		explotion_ctrl()
		GLOBAL.score += 100

func _on_audio_finished():
	queue_free()
	
	if GLOBAL.credits <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

extends Node2D


# Tambien podría ser: @export var enemy : PackedScene = preload("res://scenes/enemy.tscn")
@export var enemy : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLOBAL.score = 0
	GLOBAL.credits = 1	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parallax_bg(delta)
	$PathSpawn/PathFollow.set_progress($PathSpawn/PathFollow.get_progress() + 80 * delta)

func parallax_bg(delta_time) -> void:
	get_node("Background/Back").scroll_base_offset -= Vector2(1, 0) * 8 * delta_time
	$Background/Stars.scroll_base_offset -= Vector2(1, 0) * 16 * delta_time
	$Background/Planet_1.scroll_base_offset -= Vector2(1, 0) * 50 * delta_time
	$Background/Planet_2.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time

func _on_timer_timeout():
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = $PathSpawn/PathFollow.global_position
	add_child(enemy_instance)

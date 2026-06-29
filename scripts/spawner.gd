extends Node2D

@export var enemy_scene : PackedScene
@onready var game_space: Node2D = $".."

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = self.position
	game_space.add_child(enemy)

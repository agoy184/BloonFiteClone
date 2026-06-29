extends Node2D

@onready var scorecard: Label = $Score
@export var score: int = 0


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_enemy_score() -> void:
	score += 1
	scorecard.text = str(score)
	print(score)

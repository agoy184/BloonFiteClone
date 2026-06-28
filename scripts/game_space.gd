extends Node2D

## Temporary debug trigger: marks this level complete and returns to level
## select. Replace with a real win condition later.
@export var level_id: String = "level_1"

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("level_complete"):
		Game.mark_completed(level_id)
		get_tree().change_scene_to_file(Game.LEVEL_SELECT)
	elif event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(Game.MAIN_MENU)

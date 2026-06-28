extends Control

@onready var level_list: VBoxContainer = $CenterContainer/VBoxContainer/LevelList


func _ready() -> void:
	for level in Game.levels:
		var button := Button.new()
		button.text = level.name + ("  ✓" if Game.is_completed(level.id) else "")
		button.pressed.connect(Game.play_level.bind(level.id))
		level_list.add_child(button)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(Game.MAIN_MENU)

extends Control

@onready var volume_slider: HSlider = $CenterContainer/VBoxContainer/MasterVolume/HSlider


func _ready() -> void:
	volume_slider.value = Game.master_volume


func _on_master_volume_changed(value: float) -> void:
	Game.set_master_volume(value)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(Game.MAIN_MENU)

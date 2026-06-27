extends CanvasLayer
class_name GameOverScreen

@export_subgroup("Nodes")
@export var label: Label
@export var restart_button: Button

func _ready() -> void:
	visible = false
	restart_button.pressed.connect(_on_restart_pressed)

func show_result(text: String) -> void:
	label.text = text
	visible = true
	get_tree().paused = true

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

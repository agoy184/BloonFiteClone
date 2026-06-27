extends Node2D
class_name BalloonComponent

@export_subgroup("Nodes")
@export var balloon_scene: PackedScene

@export_subgroup("Settings")
@export var balloon_count: int = 2
@export var spacing: float = 26.0
@export var height_offset: float = -82.0
@export var pop_mode: Balloon.PopMode = Balloon.PopMode.FEET_AREA
@export var balloon_color: Color = Color(0.9, 0.3, 0.4)

@export_subgroup("Buoyancy")
@export var lift_per_balloon: float = 0.375
@export var min_gravity_multiplier: float = 0.2

## Emitted once the character has lost its last balloon.
signal all_balloons_popped

var balloons: Array[Balloon] = []

func _ready() -> void:
	var character: Node2D = get_parent()
	_spawn_balloons(character)

func _spawn_balloons(character: Node2D) -> void:
	if balloon_scene == null:
		push_warning("BalloonComponent has no balloon_scene assigned.")
		return

	for i in balloon_count:
		var balloon: Balloon = balloon_scene.instantiate()
		balloon.owner_character = character
		balloon.pop_mode = pop_mode
		balloon.color = balloon_color
		# Spread the balloons symmetrically above the head.
		var offset_x: float = (i - (balloon_count - 1) / 2.0) * spacing
		balloon.position = Vector2(offset_x, height_offset)
		balloon.popped.connect(_on_balloon_popped)
		add_child(balloon)
		balloons.append(balloon)

func _on_balloon_popped(balloon: Balloon) -> void:
	balloons.erase(balloon)
	if balloons.is_empty():
		all_balloons_popped.emit()

## Less balloons -> weaker buoyancy -> the character falls faster.
## 2 balloons ≈ 0.25, 1 ≈ 0.625, 0 = 1.0 (full gravity).
func get_gravity_multiplier() -> float:
	return clampf(1.0 - balloons.size() * lift_per_balloon, min_gravity_multiplier, 1.0)

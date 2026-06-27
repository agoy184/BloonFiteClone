extends Area2D
class_name HurtboxComponent

@export_subgroup("Nodes")
@export var character: CharacterBody2D
@export var balloon_component: BalloonComponent

## Emitted when an opponent taps this character while it is vulnerable
## (no balloons left and standing on the ground).
signal died

var _dead: bool = false

func _physics_process(_delta: float) -> void:
	if _dead or not _is_vulnerable():
		return

	# Any overlapping area here is an opponent's feet (mask = feet layer only).
	for area in get_overlapping_areas():
		if area.owner != character:
			_dead = true
			died.emit()
			return

## Vulnerable only after dropping to the ground with no balloons left,
## so a character must first fall and then be tapped again to die.
func _is_vulnerable() -> bool:
	return balloon_component.balloons.is_empty() and character.is_on_floor()

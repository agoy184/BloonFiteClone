extends Node
class_name EnemyAIComponent

@export_subgroup("Settings")
## Aim to hover this many pixels above the target (so we descend onto its balloons).
@export var hover_above: float = 40.0
@export var horizontal_deadzone: float = 6.0
## How long the enemy commits to a decision before re-evaluating. Higher = more
## sluggish and easier to dodge.
@export var reaction_time: float = 0.4

var input_horizontal: float = 0.0

var _want_jump: bool = false
var _decision_timer: float = 0.0

## Decide this frame's movement based on where the target is.
## Drop-in for InputComponent: exposes input_horizontal + get_jump_input().
func update_decision(body: Node2D, target: Node2D, delta: float) -> void:
	if target == null:
		input_horizontal = 0.0
		_want_jump = false
		return

	# Only re-evaluate every reaction_time seconds; keep the last decision in between
	# so the enemy lags behind the player and is easier to juke.
	_decision_timer -= delta
	if _decision_timer > 0.0:
		return
	_decision_timer = reaction_time

	var to_target: Vector2 = target.global_position - body.global_position

	# Move toward the target horizontally.
	if absf(to_target.x) > horizontal_deadzone:
		input_horizontal = signf(to_target.x)
	else:
		input_horizontal = 0.0

	# Float up: flap while we are below the desired altitude (above the target).
	# JumpComponent's is_jumping throttle turns a held flap into a flap-at-apex rhythm.
	var desired_y: float = target.global_position.y - hover_above
	_want_jump = body.global_position.y > desired_y

func get_jump_input() -> bool:
	return _want_jump

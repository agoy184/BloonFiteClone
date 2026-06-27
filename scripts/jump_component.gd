extends Node
class_name JumpComponent

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0
@export var air_jump_velocity: float = -200.0

var is_jumping: bool = false

func handle_jump(body:CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	if want_to_jump and not body.is_on_floor():
		if is_jumping == false:
			body.velocity.y = air_jump_velocity
	is_jumping = body.velocity.y < 0 and not body.is_on_floor()

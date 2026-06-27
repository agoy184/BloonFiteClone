extends CharacterBody2D
class_name Enemy

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var ai_component: EnemyAIComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var balloon_component: BalloonComponent

var target: Node2D

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	ai_component.update_decision(self, target, delta)
	gravity_component.handle_gravity(self, delta, balloon_component.get_gravity_multiplier())
	movement_component.handle_horizontal_movement(self, ai_component.input_horizontal)
	# No balloons -> no flapping; the enemy just falls and stays grounded.
	var wants_jump: bool = ai_component.get_jump_input() and not balloon_component.balloons.is_empty()
	jump_component.handle_jump(self, wants_jump)

	move_and_slide()

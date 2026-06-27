extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var balloon_component: BalloonComponent

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta, balloon_component.get_gravity_multiplier())
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())
	
	move_and_slide()

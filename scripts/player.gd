extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: JumpComponent

var death: bool = false

func _ready() -> void:
		set_collision_mask_value(2, true)
		set_collision_layer_value(1, true)
		set_collision_layer_value(2, true)

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	if death == false:
		movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
		animation_component.handle_move_animation(input_component.input_horizontal )
		jump_component.handle_jump(self, input_component.get_jump_input())
		animation_component.handle_jump_animation(jump_component.is_jumping, gravity_component.is_falling)
	
	move_and_slide()
	
	


func _on_balloon_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		death = true
		animation_component.death = true
		animation_component.handle_death_animation()
		movement_component.handle_death(self)
		set_collision_mask_value(2, false)
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, false)

extends CharacterBody2D

@export_subgroup("Nodes")
@export var jump_component: JumpComponent
@export var movement_component: MovementComponent
@export var gravity_componenet: GravityComponent
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _physics_process(delta: float) -> void:
	if self.is_on_floor():
		jump_component.handle_enemy_jump(self)

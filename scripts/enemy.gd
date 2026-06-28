extends CharacterBody2D

@export_subgroup("Nodes")
@export var jump_component: JumpComponent
@export var movement_component: MovementComponent
@export var gravity_component: GravityComponent
@onready var body_collision: CollisionShape2D = $BodyCollision


func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	if self.is_on_floor():
		jump_component.handle_enemy_jump(self)
	move_and_slide()

extends CharacterBody2D

@export_subgroup("Nodes")
@export var jump_component: JumpComponent
@export var movement_component: MovementComponent
@export var gravity_component: GravityComponent
@export var follow_component: FollowComponent
@onready var body_collision: CollisionShape2D = $BodyCollision


func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	var direction: float = 0.0
	if not players.is_empty():
		var player: Node2D = players[0] as Node2D
		if player:
			direction = sign(player.global_position.x - global_position.x)
	
	movement_component.handle_horizontal_movement(self, direction)
	
	if self.is_on_floor():
		jump_component.handle_enemy_jump(self)
	move_and_slide()

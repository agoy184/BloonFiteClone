extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var jump_component: JumpComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var follow_component: FollowComponent
@onready var timer: Timer = $Timer

var death: bool = false

signal score

func _ready() -> void:
	set_collision_mask_value(2, true)
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, true)

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	if death == false:
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


func _on_balloon_body_entered(body: Node2D) -> void:
	death = true
	animation_component.death = true
	animation_component.handle_death_animation()
	movement_component.handle_death(self)
	set_collision_mask_value(2, false)
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, false)
	timer.start()


func _on_timer_timeout() -> void:
	print("Timer Done")
	score.emit()
	queue_free()

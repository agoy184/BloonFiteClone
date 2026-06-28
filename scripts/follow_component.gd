extends Node
class_name FollowComponent

## The group of objects to follow.
@export var target_group: String = "Player"
## Minimum horizontal distance to maintain from the target.
@export var min_distance: float = 5.0

## The horizontal direction to the target (-1, 0, or 1).
var target_direction: float = 0.0

## Updates the target_direction based on the nearest node in target_group.
func update_direction(body: Node2D) -> void:
	var targets: Array[Node] = get_tree().get_nodes_in_group(target_group)
	if targets.is_empty():
		target_direction = 0.0
		return
		
	var nearest_target: Node2D = null
	var min_dist_sq: float = INF
	
	for target in targets:
		if target is Node2D:
			var dist_sq: float = body.global_position.distance_squared_to(target.global_position)
			if dist_sq < min_dist_sq:
				min_dist_sq = dist_sq
				nearest_target = target
				
	if nearest_target:
		var diff_x: float = nearest_target.global_position.x - body.global_position.x
		if abs(diff_x) > min_distance:
			target_direction = sign(diff_x)
		else:
			target_direction = 0.0
	else:
		target_direction = 0.0

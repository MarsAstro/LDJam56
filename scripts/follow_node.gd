extends Node3D

@export var node_to_follow: Node3D
@export var follow_distance: float = 0.1

func _process(delta: float) -> void:
	var direction: Vector3 = (node_to_follow.global_position - global_position).normalized()
	global_position = node_to_follow.global_position - direction * follow_distance

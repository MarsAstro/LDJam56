extends Node3D

@export var node_to_follow: Node3D
@export var follow_distance: float = 0.1

var gravity = 9.8 / 5

func _process(delta: float) -> void:
	var direction: Vector3 = (node_to_follow.global_position - global_position).normalized()
	global_position = node_to_follow.global_position - direction * follow_distance
	
	if (global_position.y > node_to_follow.global_position.y):
		global_position.y -= gravity * delta
		
		if (global_position.y < node_to_follow.global_position.y):
			global_position.y = node_to_follow.global_position.y

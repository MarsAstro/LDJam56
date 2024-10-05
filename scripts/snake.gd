extends Node3D

@export var snake_head: Node3D
@export var snake_front_body: Node3D
@export var snake_back_body: Node3D
@export var snake_tail: Node3D
@export var snake_mesh: MeshInstance3D

func _process(_delta: float) -> void:
	var material := snake_mesh.mesh.surface_get_material(0) as ShaderMaterial

	material.set_shader_parameter("snake_head", snake_head.global_position)
	material.set_shader_parameter("snake_front_body", snake_front_body.global_position)
	material.set_shader_parameter("snake_back_body", snake_back_body.global_position)
	material.set_shader_parameter("snake_tail", snake_tail.global_position)

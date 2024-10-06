extends Node3D

@export var snake_body: SnakeBody
@export var snake_mesh: MeshInstance3D

@export var slither_snake_front_body: Node3D
@export var slither_snake_back_body: Node3D
@export var slither_snake_tail: Node3D

@export var coil_snake_front_body: Node3D
@export var coil_snake_back_body: Node3D
@export var coil_snake_tail: Node3D

func _process(_delta: float) -> void:
	#var material := snake_mesh.mesh.surface_get_material(0) as ShaderMaterial
	#material.set_shader_parameter("snake_head", snake_body.global_position)
	
	var front_pos = slither_snake_front_body.global_position.slerp(coil_snake_front_body.global_position, snake_body.coil_amount)
	var back_pos = slither_snake_back_body.global_position.slerp(coil_snake_back_body.global_position, snake_body.coil_amount)
	var tail_pos = slither_snake_tail.global_position.slerp(coil_snake_tail.global_position, snake_body.coil_amount)
	
	#material.set_shader_parameter("snake_front_body", front_pos)
	#material.set_shader_parameter("snake_back_body", back_pos)
	#material.set_shader_parameter("snake_tail", tail_pos)

extends Node3D

@onready var top_booby: Node3D = $TopBooby
@onready var armature: Node3D = $TopBooby/Armature
@onready var skeleton: Skeleton3D = $TopBooby/Armature/Skeleton3D
@onready var indicator_thing: MeshInstance3D = $IndicatorThing

var bone_index: int = 0
var timer: float

func _process(delta: float) -> void:
	timer += delta
	if timer > 1.0:
		timer = 0.0
		bone_index = (bone_index + 1) % 12
	
	var input_dir := Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	var direction := (transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()
	
	top_booby.position += direction * delta
	#armature.rotate_y(delta)
	
	var previous_global_pos = armature.global_position
	
	for bone_id in 12:
		var bone_rest = skeleton.get_bone_rest(bone_id)
		var bone_global_pos = previous_global_pos + bone_local_to_global(bone_rest.origin, armature.transform.basis)
		var needed_translation = Vector3.ZERO
		previous_global_pos = bone_global_pos

		if bone_id == bone_index:
			var new_bone_global_pos = bone_global_pos + 0.1 * armature.transform.basis.x
			#indicator_thing.global_position = bone_global_pos + 0.1 * armature.transform.basis.x
			var global_pos_diff = new_bone_global_pos - bone_global_pos
			needed_translation = global_to_bone_local(global_pos_diff, armature.transform.basis)
	
		skeleton.set_bone_pose(bone_id, bone_rest.translated(needed_translation))


func bone_local_to_global(bone_origin: Vector3, snake_basis: Basis) -> Vector3:
	var new_global_pos: Vector3
	new_global_pos += snake_basis.x *  bone_origin.x
	new_global_pos += snake_basis.z *  bone_origin.y
	new_global_pos += snake_basis.y * -bone_origin.z
	
	return new_global_pos


func global_to_bone_local(global_offset: Vector3, snake_basis: Basis) -> Vector3:
	var new_local_pos: Vector3
	var scale_factor: float = armature.scale.x
	new_local_pos.x = global_offset.project(snake_basis.x).length() / scale_factor
	new_local_pos.y = global_offset.project(snake_basis.z).length() / scale_factor
	new_local_pos.z = global_offset.project(-snake_basis.y).length() / scale_factor
	
	return new_local_pos

extends Node3D

@onready var top_booby: Node3D = $TopBooby
@onready var armature: Node3D = $TopBooby/Armature
@onready var skeleton: Skeleton3D = $TopBooby/Armature/Skeleton3D
@onready var indicator_thing: MeshInstance3D = $IndicatorThing

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	var input_dir := Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	var direction := (transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()
	
	top_booby.position += direction * delta
	
	var previous_global_pos = armature.global_position
	var needed_translation
	
	for bone_id in 12:
		var bone_rest = skeleton.get_bone_rest(bone_id)
		var bone_global_pos = previous_global_pos + bone_rest.origin
		needed_translation = previous_global_pos - bone_global_pos
		previous_global_pos = previous_global_pos + needed_translation
		
		print(bone_global_pos)
		
		if bone_id == 11:
			needed_translation = indicator_thing.global_position - bone_global_pos
	
	#skeleton.set_bone_pose(bone_id, bone_rest.translated(needed_translation))
	#print(skeleton.get_bone_global_rest(1).origin)

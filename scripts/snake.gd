extends Node3D

@export var snake_body: SnakeBody
@export var snake_skeleton: Skeleton3D

@export var slither_snake_front_body: Node3D
@export var slither_snake_back_body: Node3D
@export var slither_snake_tail: Node3D

@export var coil_snake_front_body: Node3D
@export var coil_snake_back_body: Node3D
@export var coil_snake_tail: Node3D

@export var body_path: Path3D
@export var body_path_follow: PathFollow3D

@onready var test_1: MeshInstance3D = $Test1
@onready var test_2: MeshInstance3D = $Test2
@onready var test_3: MeshInstance3D = $Test3
@onready var test_4: MeshInstance3D = $Test4

var bone_count: int
var path_follow_nodes: Array[PathFollow3D]

func _ready() -> void:
	bone_count = snake_skeleton.get_bone_count()
	
	for i in bone_count:
		var new_node = PathFollow3D.new()
		body_path.add_child(new_node)
		path_follow_nodes.append(new_node)

func _process(_delta: float) -> void:
	var head_pos = snake_body.global_position
	var front_pos = slither_snake_front_body.global_position.slerp(coil_snake_front_body.global_position, snake_body.coil_amount)
	var back_pos = slither_snake_back_body.global_position.slerp(coil_snake_back_body.global_position, snake_body.coil_amount)
	var tail_pos = slither_snake_tail.global_position.slerp(coil_snake_tail.global_position, snake_body.coil_amount)
	
	var front_control_line = (head_pos - back_pos).normalized() / 2.0
	var back_control_line = (front_pos - tail_pos).normalized() / 2.0
	
	var curve = Curve3D.new()
	curve.add_point(head_pos)
	curve.add_point(front_pos, front_control_line, -front_control_line)
	curve.add_point(back_pos, back_control_line, -back_control_line)
	curve.add_point(tail_pos)
	
	body_path.curve = curve
	
	test_1.global_position = path_follow_nodes[0].global_position
	test_2.global_position = path_follow_nodes[3].global_position
	test_3.global_position = path_follow_nodes[7].global_position
	test_4.global_position = path_follow_nodes[bone_count - 1].global_position
	
	for i in float(bone_count):
		var percent: float = i / bone_count
		path_follow_nodes[i].progress_ratio = percent
		
		var rest = snake_skeleton.get_bone_global_rest(int(i))
		var new_pose = rest.translated(path_follow_nodes[i].global_position)
		
		snake_skeleton.set_bone_global_pose(int(i), new_pose)

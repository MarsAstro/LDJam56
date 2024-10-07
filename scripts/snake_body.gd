class_name SnakeBody
extends CharacterBody3D

const SLITHER_SPEED = 4.0
const COIL_SPEED = 12.0
const JUMP_VELOCITY: float = 6
const MOUSE_SENSITIVITY: float = 0.05
const GAMEPAD_SENSITIVITY: float = 2
const DEADZONE: float = 0.1

var speed: float
var coil_amount: float
var last_floor_angle: float

@export var camera_pivot: Node3D
@export var camera: Camera3D
@export var coil_pivot: Node3D
@export var coiling_speed: float = 4

@onready var coil_collider: CollisionShape3D = $CoilCollider
@onready var head_collider: CollisionShape3D = $HeadCollider

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
		camera_pivot.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSITIVITY))
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-60), deg_to_rad(15))


func _process(delta: float) -> void:
	var cameraHorizontalInput: float = Input.get_axis("camera_right", "camera_left")
	var cameraVerticalInput: float = Input.get_axis("camera_down", "camera_up")
	
	if cameraHorizontalInput > DEADZONE or cameraHorizontalInput < -DEADZONE:
		rotate_y(cameraHorizontalInput * delta * GAMEPAD_SENSITIVITY)
	if cameraVerticalInput > DEADZONE or cameraVerticalInput < -DEADZONE:
		camera_pivot.rotate_x(cameraVerticalInput * delta * GAMEPAD_SENSITIVITY)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-60), deg_to_rad(15))
		
	if Input.is_action_pressed("coil"):
		coil_amount = clamp(coil_amount + delta * coiling_speed, 0.0, 1.0)
		coil_pivot.rotate_x(-delta * 10.0 * coil_amount)
	else:
		coil_amount = clamp(coil_amount - delta * coiling_speed, 0.0, 1.0)
		var current_x_rot = coil_pivot.rotation.x
		
		if (current_x_rot >= 0.01 or current_x_rot <= -0.01):
			coil_pivot.rotation.x = move_toward(current_x_rot, 0.0, delta * 10.0)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and coil_amount >= 1.0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if is_on_floor():
		speed = lerp(SLITHER_SPEED, COIL_SPEED, coil_amount)
		if coil_amount >= 1.0:
			head_collider.disabled = true
			coil_collider.disabled = false
		else:
			head_collider.disabled = false
			coil_collider.disabled = true
	
	var input_dir := Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	var strafe_speed: float = 0.0 if Input.is_action_pressed("coil") else 1.0
	var forward_speed: float = -1.0 if Input.is_action_pressed("coil") else -input_dir.y
	var direction := (transform.basis * Vector3(-input_dir.x * strafe_speed, 0, forward_speed)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
			
		var right_vector = global_transform.basis.x
		velocity = velocity.rotated(right_vector, last_floor_angle / 20.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)

	move_and_slide()
	
	if is_on_floor():
		last_floor_angle = get_floor_angle()

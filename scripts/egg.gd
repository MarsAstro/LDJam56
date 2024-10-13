class_name Egg
extends Area3D

@export var magnet_speed: float = 5

var has_target: bool = false
var target: SnakeBody

func _process(delta: float) -> void:
	if has_target:
		var direction = (target.global_position - position).normalized()
		position += direction * magnet_speed * delta

func _on_body_entered(body: SnakeBody) -> void:
	has_target = true
	target = body

func _on_collection_hitbox_body_entered(_body: SnakeBody) -> void:
	GameManager.eat_egg()
	queue_free()

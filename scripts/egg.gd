class_name Egg
extends Area3D

func _on_body_entered(_body: SnakeBody) -> void:
	GameManager.eat_egg()
	queue_free()

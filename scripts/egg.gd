class_name Egg
extends Area3D

func _on_body_entered(_body: SnakeBody) -> void:
	GameManager.eggs_eaten += 1
	queue_free()

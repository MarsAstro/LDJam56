extends Area3D

func _on_body_entered(body: SnakeBody) -> void:
	get_tree().reload_current_scene()

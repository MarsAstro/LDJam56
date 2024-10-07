extends Area3D

func _on_body_entered(_body: SnakeBody) -> void:
	GameManager.eggs_eaten = 0
	get_tree().call_deferred("reload_current_scene")

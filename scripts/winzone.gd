extends Area3D


func _on_body_entered(body: SnakeBody) -> void:
	GameManager.is_win = true

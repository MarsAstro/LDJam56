extends Label


func _process(delta: float) -> void:
	visible = GameManager.is_win

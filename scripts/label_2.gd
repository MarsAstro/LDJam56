extends Label


func _process(_delta: float) -> void:
	visible = GameManager.is_win

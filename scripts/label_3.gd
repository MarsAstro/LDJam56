extends Label


func _process(_delta: float) -> void:
	text = str(GameManager.time_elapsed).pad_decimals(2)

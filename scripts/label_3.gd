extends Label


func _process(delta: float) -> void:
	text = str(GameManager.time_elapsed).pad_decimals(2)

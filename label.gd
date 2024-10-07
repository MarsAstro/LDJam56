extends Label

func _process(_delta: float) -> void:
	text = "Eggs Eaten: " + str(GameManager.eggs_eaten)

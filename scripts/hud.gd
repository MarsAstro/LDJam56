extends Control

@onready var egg_counter: Label = $EggCounter
@onready var timer: Label = $Timer
@onready var win_text: Label = $WinText

func _process(delta: float) -> void:
	egg_counter.text = "Eggs Eaten: " + str(GameManager.eggs_eaten) + " / 30"
	timer.text = str(GameManager.time_elapsed).pad_decimals(2)
	win_text.visible = GameManager.is_win

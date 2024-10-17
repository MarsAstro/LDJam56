extends Node

var eggs_eaten: int = 0
var is_win: bool = false
var time_elapsed: float = 0.0

@onready var eat_sound: AudioStreamPlayer = $EatSound

func _ready() -> void:
	GameManager.time_elapsed = 0.0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart_level"):
		restart_level()
		
func eat_egg() -> void:
	eggs_eaten += 1
	eat_sound.stop()
	eat_sound.play()

func restart_level() -> void:
	eggs_eaten = 0
	is_win = false
	time_elapsed = 0.0
	get_tree().call_deferred("reload_current_scene")

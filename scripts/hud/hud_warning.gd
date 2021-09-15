extends Control

onready var time_texture = $Time
onready var rings_texture = $Rings

onready var score_manager = get_node("/root/ScoreManager")

var time: float

const TIME_WARNING = 595

func _process(delta):
	handle_blink(delta)
	check_status()

func handle_blink(delta: float):
	time += delta
	visible = fmod(time, 0.5) > 0.2

func check_status():
	time_texture.visible = score_manager.time > TIME_WARNING
	rings_texture.visible = score_manager.rings == 0

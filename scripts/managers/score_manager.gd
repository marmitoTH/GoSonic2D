extends Node

var score = 0
var rings = 0
var lifes = 3

var time: float
var time_stoped: bool

signal ring_added
signal score_added
signal life_added
signal time_over

const TIME_LIMIT = 600

func _process(delta):
	handle_time(delta)

func handle_time(delta: float):
	if not time_stoped:
		var next_time = time + delta
		if (next_time < TIME_LIMIT):
			time += delta
		else:
			time_stoped = true
			emit_signal("time_over")

func add_score(amount = 1):
	if amount > 0:
		score += amount
		emit_signal("score_added", score)

func add_ring(amount = 1):
	if amount > 0:
		rings += amount
		emit_signal("ring_added", rings)

func add_life(amount = 1):
	if amount > 0:
		lifes += amount
		emit_signal("life_added", lifes)

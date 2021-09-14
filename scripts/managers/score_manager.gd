extends Node

var score = 0
var rings = 0
var lifes = 3

var time: float

signal ring_added
signal score_added
signal life_added

func _process(delta):
	time += delta

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

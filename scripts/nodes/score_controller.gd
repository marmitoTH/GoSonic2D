extends Node

class_name ScoreController

export(int) var score
export(int) var rings
export(int) var lifes

onready var score_manager = get_node("/root/ScoreManager") as ScoreManager

func add_score():
	score_manager.add_score(score)
	score_manager.add_ring(rings)
	score_manager.add_life(lifes)

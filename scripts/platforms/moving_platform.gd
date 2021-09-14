extends Node2D

export(float) var amplitude = 50
export(float) var period = 1

onready var center = position

var time: float

func _physics_process(delta):
	time += delta
	position.x = center.x + amplitude * cos(period * time)
	position.y = center.y + amplitude * sin(period * time)

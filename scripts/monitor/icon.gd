extends Node2D

export(float) var move_height = 50
export(float) var move_speed = 130
export(float) var visible_time = 2

var destination: Vector2
var movement: bool
var visible_timer: float

func _ready():
	destination = Vector2.UP * move_height

func _process(delta):
	if movement:
		handle_movement(delta)
		handle_visibility(delta)

func handle_movement(delta: float):
	var speed = move_speed * delta
	position = position.move_toward(destination, speed)

func handle_visibility(delta: float):
	if visible_timer <= visible_time:
			visible_timer += delta
	else:
		visible_timer = 0
		visible = false

func set_movement(value: bool):
	movement = value

extends Node2D

class_name Zone

export(PackedScene) var player_resource
export(PackedScene) var camera_resource

export(float) var limit_left = 0
export(float) var limit_right = 10000
export(float) var limit_top = 0
export(float) var limit_bottom = 10000

onready var start_point = $StartPoint

var player: Player
var camera: PlayerCamera

func _ready():
	initialize_player()
	initialize_camera()

func initialize_player():
	player = player_resource.instance()
	player.position = start_point.position
	player.lock_to_limits(limit_left, limit_right)
	add_child(player)

func initialize_camera():
	camera = camera_resource.instance()
	camera.set_player(player)
	camera.set_limits(limit_left, limit_right, limit_top, limit_bottom)
	add_child(camera)

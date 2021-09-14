extends Node

class_name DebugHUD

export(NodePath) var player_path

onready var x_pos = $Labels/XPOS
onready var y_pos = $Labels/YPOS
onready var x_sp = $Labels/XSP
onready var y_sp = $Labels/YSP

onready var player = get_node(player_path) as Player

const FORMAT = "%.2f"

func _process(_delta):
	var player_position = player.position
	var player_velocity = player.velocity
	
	x_pos.text = FORMAT % player_position.x
	y_pos.text = FORMAT % player_position.y
	x_sp.text = FORMAT % player_velocity.x
	y_sp.text = FORMAT % player_velocity.y

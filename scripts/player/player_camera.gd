extends Camera2D

class_name PlayerCamera

export(float) var max_speed = 960
export(float) var right_margin = 0
export(float) var left_margin = -16
export(float) var top_margin = -32
export(float) var bottom_margin = 32

var player: Player

func _ready():
	initialize_camera()

func _physics_process(delta):
	handle_horizontal_borders(delta)
	handle_vertical_borders(delta)

func initialize_camera():
	current = true

func set_player(desired_player: Player):
	player = desired_player
	position = player.global_position

func set_limits(left: int, right: int, top: int, bottom: int):
	limit_left = left
	limit_right = right
	limit_top = top
	limit_bottom = bottom

func handle_horizontal_borders(delta: float):
	var pivot_offset = player.current_bounds.offset
	var target = player.global_position.x + pivot_offset.x
	
	if target > position.x + right_margin:
		var offset = target - position.x - right_margin
		position.x += min(offset, max_speed * delta)
	
	if target < position.x + left_margin:
		var offset = target - position.x - left_margin
		position.x += max(offset, -max_speed * delta)

func handle_vertical_borders(delta: float):
	var pivot_offset = player.current_bounds.offset
	var target = player.global_position.y + pivot_offset.y
	
	if player.is_grounded:
		var offset = target - position.y
		position.y += clamp(offset, -max_speed * delta, max_speed * delta * 0.5)
	else:
		if target < position.y + top_margin :
			var offset = target - position.y - top_margin
			position.y += max(offset, -max_speed * delta)
		
		if target > position.y + bottom_margin:
			var offset = target - position.y - bottom_margin
			position.y += min(offset, max_speed * delta)

#func _draw():
#	var right = Vector2.RIGHT * right_margin
#	var left = Vector2.RIGHT * left_margin
#	var top_left = Vector2.UP * -top_margin + left
#	var top_right = Vector2.UP * -top_margin + right
#	var bottom_left = Vector2.DOWN * bottom_margin + left
#	var bottom_right = Vector2.DOWN * bottom_margin + right
#	draw_line(top_left, bottom_left, Color.white)
#	draw_line(top_right, bottom_right, Color.white)
#	draw_line(top_left, top_right, Color.white)
#	draw_line(bottom_left, bottom_right, Color.white)
#	draw_line(right, left, Color.green)

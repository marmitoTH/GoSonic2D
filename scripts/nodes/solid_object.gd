extends StaticBody2D

class_name SolidObject

onready var shape = $CollisionShape2D

# warning-ignore:unused_signal
signal player_right_wall_collision(player)

# warning-ignore:unused_signal
signal player_left_wall_collision(player)

# warning-ignore:unused_signal
signal player_ceiling_collision(player)

# warning-ignore:unused_signal
signal player_ground_collision(player)

func set_enabled(value: bool):
	shape.disabled = not value

func is_enabled() -> bool:
	return not shape.disabled

extends Node2D

class_name Spring

export(float) var power = 600
export(int, "Vertical", "Horizontal") var type

onready var collider = $SolidObject/CollisionShape2D

func apply_vertical_force(player: Player, direction: int):
	if player.is_grounded:
		player.exit_ground()
	
	player.velocity.y = power * -direction

func apply_horizontal_force(player: Player, direction: int):
	player.lock_controls()
	player.skin.handle_flip(direction)
	player.velocity.x = power * direction

func _on_SolidObject_player_right_wall_collision(player: Player):
	if type == 1:
		apply_horizontal_force(player, -1)
	elif type == 0:
		if abs(player.rotation_degrees) == 90:
			apply_horizontal_force(player, -1)

func _on_SolidObject_player_left_wall_collision(player: Player):
	if type == 1:
		apply_horizontal_force(player, 1)
	elif type == 0:
		if abs(player.rotation_degrees) == 90:
			apply_horizontal_force(player, 1)

func _on_SolidObject_player_ground_collision(player: Player):
	if type == 0:
		apply_vertical_force(player, 1)

func _on_SolidObject_player_ceiling_collision(player: Player):
	if type == 0:
		apply_vertical_force(player, -1)

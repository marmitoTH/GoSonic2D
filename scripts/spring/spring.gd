extends Node2D

class_name Spring

export(bool) var positive = true
export(float) var power = 600
export(int, "Vertical", "Horizontal") var type

onready var collider = $SolidObject/CollisionShape2D

func get_signal():
	return 1 if positive else -1

func apply_vertical_force(player: Player, direction: int):
	if abs((position - player.position).normalized().y) >= 0.5:
		if player.is_grounded:
			player.lock_controls()
			player.skin.handle_flip(direction)
		
		player.velocity.y = power * -direction

func apply_horizontal_force(player: Player, direction: int):
	if abs((position - player.position).normalized().x) >= 0.5:
		player.lock_controls()
		player.skin.handle_flip(direction)
		player.velocity.x = power * direction

func _on_SolidObject_player_overlap(player: Player):
	var direction = get_signal()
	
	match type:
		0:
			apply_vertical_force(player, direction)
		1:
			apply_horizontal_force(player, direction)

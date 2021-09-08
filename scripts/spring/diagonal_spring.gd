extends Node2D

class_name DiagonalSpring

export(bool) var positive = true
export(float) var power = 600
export(int, "Upward", "Downward") var type

func apply_force(player: Player):
	var horizontal_sign = 1 if positive else -1
	var vertical_sign = -1 if type == 0 else 1
	var direction = (position - player.position).normalized()
	
	if sign(direction.y) != vertical_sign:
			player.velocity = Vector2(power * horizontal_sign, power * vertical_sign)

func _on_Area2D_area_entered(area: Area2D):
	var player = area.get_parent()
	
	if player is Player:
		apply_force(player)

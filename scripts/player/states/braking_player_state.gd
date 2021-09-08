extends PlayerState

class_name BrakingPlayerState

func step(player: Player, delta: float):
	player.handle_fall()
	player.handle_jump()
	player.handle_deceleration(delta)
	
	if player.is_grounded:
		if player.input_dot_velocity >= 0:
			player.state_machine.change_state("Regular")
		elif player.input_direction.y < 0:
			player.state_machine.change_state("Rolling")
	else:
		player.state_machine.change_state("Air")

func animate(player: Player, _delta: float):
	player.skin.handle_flip(player.velocity.x)
	player.skin.set_root_state(PlayerSkin.ROOT_STATES.skidding)

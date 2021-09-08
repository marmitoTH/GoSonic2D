extends PlayerState

class_name RegularPlayerState

func enter(player: Player):
	player.is_rolling = false
	player.set_bounds(0)

func step(player: Player, delta: float):
	player.handle_fall()
	player.handle_gravity(delta)
	player.handle_jump()
	player.handle_slope(delta)
	player.handle_acceleration(delta)
	player.handle_friction(delta)

	if not player.is_grounded:
		player.state_machine.change_state("Air")
	else:
		if player.input_dot_velocity < 0:
			player.state_machine.change_state("Braking")
		if player.input_direction.y < 0 and abs(player.velocity.x) > player.current_stats.min_speed_to_roll:
			player.state_machine.change_state("Rolling")

func animate(player: Player, _delta: float):
	var absolute_speed = abs(player.velocity.x)
	var ground_state = PlayerSkin.GROUND_STATES.idle
	
	player.skin.handle_flip(player.input_direction.x)
	player.skin.set_root_state(PlayerSkin.ROOT_STATES.ground)
	player.skin.set_ground_time(max(8.0 / 60.0 + absolute_speed / 120.0, 1.0))
	
	if absolute_speed >= 0.3 and absolute_speed <= 355:
		ground_state = PlayerSkin.GROUND_STATES.walking
	elif absolute_speed > 355 and absolute_speed <= 595:
		ground_state = PlayerSkin.GROUND_STATES.running
	elif absolute_speed > 595:
		ground_state = PlayerSkin.GROUND_STATES.peel_out
	
	player.skin.set_ground_state(ground_state)

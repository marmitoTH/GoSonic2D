extends PlayerState

class_name RollingPlayerState

func enter(player: Player):
	player.is_rolling = true
	player.set_bounds(1)

func step(player: Player, delta: float):
	player.handle_fall()
	player.handle_gravity(delta)
	player.handle_jump()
	player.handle_slope(delta)
	player.handle_acceleration(delta)
	player.handle_friction(delta)
	
	if player.is_grounded:
		if abs(player.velocity.x) < player.current_stats.unroll_speed:
			player.state_machine.change_state("Regular")
	else:
		player.state_machine.change_state("Air")

func animate(player: Player, _delta: float):
	player.skin.set_rolling_time(max(4 / 60.0 + abs(player.velocity.x) / 120.0, 1.0))
	player.skin.set_root_state(PlayerSkin.ROOT_STATES.rolling)

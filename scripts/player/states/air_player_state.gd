extends PlayerState

class_name AirPlayerState

var last_absolute_horizontal_speed : float

func enter(player: Player):
	if player.is_jumping:
		player.is_rolling = true
		player.set_bounds(1)
		last_absolute_horizontal_speed = abs(player.velocity.x)

func step(player: Player, delta: float):
	player.handle_gravity(delta)
	player.handle_jump()
	player.handle_acceleration(delta)

	if player.is_grounded:
		if player.input_direction.y < 0:
			player.state_machine.change_state("Rolling")
		else:
			player.state_machine.change_state("Regular")

func animate(player: Player, _delta: float):
	player.skin.handle_flip(player.input_direction.x)

	if not player.is_grounded and player.is_rolling:
		player.skin.set_rolling_time(max(4 / 60.0 + last_absolute_horizontal_speed / 120.0, 1.0))
		player.skin.set_root_state(PlayerSkin.ROOT_STATES.rolling)

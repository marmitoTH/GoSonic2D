extends PlayerState

class_name SpringPlayerState

func enter(player: Player):
	player.is_jumping = false
	player.is_rolling = false
	player.set_bounds(0)

func step(player: Player, delta: float):
	player.handle_gravity(delta)
	player.handle_acceleration(delta)
	
	if player.is_grounded():
		player.state_machine.change_state("Regular")
	elif player.velocity.y > 0:
		player.state_machine.change_state("Air")

func animate(player: Player, _delta: float):
	player.skin.set_animation_speed(1.5)
	player.skin.handle_flip(player.input_direction.x)
	player.skin.set_animation_state(PlayerSkin.ANIMATION_STATES.corkscrew)

extends Node2D

class_name PlayerStateMachine

export(String) var initial_state = "Regular"

onready var player = get_parent()

onready var states = {
	"Regular": $Regular,
	"Rolling": $Rolling,
	"Braking": $Braking,
	"Air": $Air
}

var current_state

func initialize():
	change_state(initial_state)

func change_state(to: String):
	if current_state:
		current_state.exit(player)

	current_state = states[to]
	current_state.enter(player)

func update_state(delta: float):
	if current_state:
		current_state.step(player, delta)

func animate_state(delta: float):
	if current_state:
		current_state.animate(player, delta)

extends Sprite

class_name PlayerSkin

onready var animation_tree = $AnimationTree

const ANIMATION_STATES = {
	"idle": 0,
	"walking": 1,
	"running": 2,
	"peel_out": 3,
	"rolling": 4,
	"skidding": 5,
	"corkscrew": 6
}

var current_state : int

func handle_flip(direction: float) -> void:
	if direction != 0:
		flip_h = direction < 0

func set_animation_state(state: int) -> void:
	if state != current_state:
		current_state = state
		animation_tree.set("parameters/state/current", current_state)

func set_animation_speed(value: float) -> void:
	animation_tree.set("parameters/speed/scale", value)

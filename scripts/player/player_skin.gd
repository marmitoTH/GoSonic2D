extends Sprite

class_name PlayerSkin

onready var animation_tree = $AnimationTree

const ROOT_STATES = {
	"ground": 0,
	"rolling": 1,
	"skidding": 2
}

const GROUND_STATES = {
	"idle": 0,
	"walking": 1,
	"running": 2,
	"peel_out": 3
}

var current_root_state : int
var current_ground_state : int

func handle_flip(direction: float) -> void:
	if direction != 0:
		flip_h = direction < 0

func set_root_state(state: int) -> void:
	if state != current_root_state:
		current_root_state = state
		animation_tree.set("parameters/root_state/current", state)

func set_ground_state(state: int) -> void:
	if state != current_ground_state:
		current_ground_state = state
		animation_tree.set("parameters/ground/current", state)

func set_ground_time(value: float) -> void:
	animation_tree.set("parameters/ground_time/scale", value)

func set_rolling_time(value: float) -> void:
	animation_tree.set("parameters/rolling_time/scale", value)

extends Node2D

class_name Spring

export(float) var power = 600
export(int, "Vertical", "Horizontal") var type
export(NodePath) var spring_audio_path

onready var animation_tree = $Sprite/AnimationTree
onready var collider = $SolidObject/CollisionShape2D

onready var spring_audio = get_node(spring_audio_path) as AudioStreamPlayer

func activate():
	spring_audio.play()
	animation_tree.set("parameters/state/active", true)

func apply_vertical_force(player: Player, direction: int):
	if player.is_grounded:
		player.exit_ground()
	
	player.velocity.y = power * -direction
	activate()

func apply_horizontal_force(player: Player, direction: int):
	player.lock_controls()
	player.skin.handle_flip(direction)
	player.velocity.x = power * direction
	activate()

func _on_SolidObject_player_right_wall_collision(player: Player):
	if type == 1:
		apply_horizontal_force(player, -1)
	elif type == 0:
		if abs(player.rotation_degrees) == 90:
			apply_horizontal_force(player, -1)

func _on_SolidObject_player_left_wall_collision(player: Player):
	if type == 1:
		apply_horizontal_force(player, 1)
	elif type == 0:
		if abs(player.rotation_degrees) == 90:
			apply_horizontal_force(player, 1)

func _on_SolidObject_player_ground_collision(player: Player):
	if type == 0 and player.velocity.y >= 0:
		player.state_machine.change_state("Spring")
		apply_vertical_force(player, 1)

func _on_SolidObject_player_ceiling_collision(player: Player):
	if type == 0 and player.velocity.y <= 0:
		apply_vertical_force(player, -1)

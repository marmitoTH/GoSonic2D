extends Node2D

class_name Monitor

export(float) var bump_force = 150
export(float) var gravity = 700
export(float) var ground_distance = 16

export(int, LAYERS_2D_PHYSICS) var ground_layer = 1

onready var tree = get_tree()
onready var world = get_world_2d()

onready var icon = $Icon
onready var explosion = $Explosion0

onready var solid_object = $SolidObject
onready var animation_tree = $Sprite/AnimationTree
onready var score_controller = $ScoreController

onready var item_audio = $Audios/ItemAudio
onready var explosion_audio = $Audios/ExplosionAudio

var velocity: Vector2

var destroyed: bool
var allow_movement: bool

func _process(delta):
	if allow_movement:
		handle_movement(delta)
		handle_collision()

func handle_movement(delta: float):
	velocity.y += gravity * delta
	position += velocity * delta

func handle_collision():
	var ground_hit = GoPhysics.cast_ray(world, position, transform.y, 
		ground_distance, [solid_object], ground_layer)
	
	if ground_hit:
		allow_movement = false
		velocity = Vector2.ZERO
		position -= transform.y * ground_hit.penetration

func destroy():
	if not destroyed:
		explosion.play()
		icon.set_movement(true)
		explosion_audio.play()
		solid_object.set_enabled(false)
		animation_tree.set("parameters/state/current", 1)
		handle_item()

func handle_item():
	yield(tree.create_timer(0.5), "timeout")
	item_audio.play()
	score_controller.add_score()

func bump_up():
	allow_movement = true
	velocity.y = -bump_force

func _on_SolidObject_player_ceiling_collision(player: Player):
	if player.velocity.y <= 0:
		bump_up()

func _on_SolidObject_player_ground_collision(player: Player):
	if player.is_rolling and player.velocity.y > 0:
		player.velocity.y = -player.velocity.y
		destroy()

func _on_SolidObject_player_left_wall_collision(player: Player):
	if player.is_grounded and player.is_rolling:
		destroy()

func _on_SolidObject_player_right_wall_collision(player: Player):
	if player.is_grounded and player.is_rolling:
		destroy()

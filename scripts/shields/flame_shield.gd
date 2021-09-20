extends Shield

export(float) var horizontal_force = 480
export(float) var attacking_sprite_offset = -12

onready var shield_sprite = $ShieldSprite
onready var attacking_sprite = $AttackingSprite

onready var shield_animation_player = $ShieldSprite/AnimationPlayer
onready var attacking_animation_player = $AttackingSprite/AnimationPlayer

func on_activate():
	set_attacking(false)
	shield_user.connect("ground_enter", self, "on_user_ground_enter")

func on_deactivate():
	shield_sprite.visible = false
	attacking_sprite.visible = false
	shield_animation_player.stop()
	attacking_animation_player.stop()

func on_action():
	var direction = -1 if shield_user.skin.flip_h else 1
	shield_user.velocity.x = horizontal_force * direction
	shield_user.velocity.y = 0
	attacking_sprite.offset.x = attacking_sprite_offset * direction
	attacking_sprite.flip_h = shield_user.skin.flip_h
	set_attacking(true)

func set_attacking(value: bool):
	attacking_sprite.visible = value
	shield_sprite.visible = not value
	
	if value:
		shield_animation_player.stop()
		attacking_animation_player.play("default")
	else:
		attacking_animation_player.stop()
		shield_animation_player.play("default")

func on_user_ground_enter():
	set_attacking(false)

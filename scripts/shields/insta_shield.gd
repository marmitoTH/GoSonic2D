extends Shield

onready var sprite = $Sprite
onready var animation_player = $Sprite/AnimationPlayer
onready var collision = $Area2D/CollisionShape2D

func _ready():
	set_attacking(false)

func on_action():
	set_attacking(true)
	animation_player.play("default")
	yield(animation_player, "animation_finished")
	set_attacking(false)

func set_attacking(value: bool):
	invincible = value
	sprite.visible = value
	collision.set_deferred("disabled", not value)

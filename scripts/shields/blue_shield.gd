extends Shield

onready var sprite = $Sprite
onready var animation_player = $Sprite/AnimationPlayer

func _ready():
	sprite.visible = false

func on_activate():
	sprite.visible = true
	animation_player.play("default")

func on_deactivate():
	sprite.visible = false
	animation_player.stop()

extends Sprite

class_name Particle

export(String) var animation_name

onready var animation_player = $AnimationPlayer

func _ready():
	stop()

func play():
	visible = true
	animation_player.play(animation_name)

func stop():
	visible = false
	animation_player.stop()

func _on_AnimationPlayer_animation_finished(_anim_name):
	stop()

extends Node2D

onready var sprite = $Sprite
onready var collider = $Area2D/CollisionShape2D
onready var score_controller = $ScoreController
onready var ring_audio = $RingAudio

func collect():
	ring_audio.play()
	sprite.visible = false
	score_controller.add_score()
	collider.set_deferred("disabled", true)

func _on_Area2D_area_entered(area):
	var player = area.get_parent()
	
	if player is Player:
		collect()

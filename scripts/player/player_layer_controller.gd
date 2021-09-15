extends Area2D

class_name PlayerLayerController

export(int, LAYERS_2D_PHYSICS) var wall_layer = 1
export(int, LAYERS_2D_PHYSICS) var ground_layer = 1
export(int, LAYERS_2D_PHYSICS) var ceiling_layer = 1

func _on_Area2D_area_entered(area):
	var player = area.get_parent()
	
	if player is Player:
		player.wall_layer = wall_layer
		player.ground_layer = ground_layer
		player.ceiling_layer = ceiling_layer

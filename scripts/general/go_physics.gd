extends Node

class_name GoPhysics

const EPSILON = 0.001
const MAX_RAY_ORIGIN_OVERLAPS = 1

static func cast_ray(world: World2D, origin: Vector2, direction: Vector2, length: float, exclude: Array = [], layer: int = 1) -> Dictionary:
	var destination = origin + direction * length
	var space_state = world.direct_space_state
	var result = space_state.intersect_ray(origin, destination, exclude, layer)
	var overlaps = space_state.intersect_point(origin, MAX_RAY_ORIGIN_OVERLAPS, exclude, layer)

	if result and overlaps.size() == 0:
		var penetration = destination.distance_to(result.position)
		return { 'position': result.position, 'normal': result.normal, 'penetration': penetration, 'collider': result.collider }
	
	return {}

static func cast_parallel_rays(world: World2D, origin: Vector2, offset: Vector2, direction: Vector2, length: float, exclude: Array = [], layer: int = 1) -> Dictionary:
	var right_ray = cast_ray(world, origin + offset, direction, length, exclude, layer)
	var left_ray = cast_ray(world, origin - offset, direction, length, exclude, layer)

	if right_ray or left_ray:
		var closest_ray = right_ray if right_ray else left_ray
		
		if left_ray and right_ray:
			var right_ray_distance = origin.distance_to(right_ray.position)
			var left_ray_distance = origin.distance_to(left_ray.position)
			closest_ray = right_ray if right_ray_distance <= left_ray_distance else left_ray
		
		return { 'right_hit': right_ray, 'left_hit': left_ray, 'closest_hit': closest_ray }
	
	return {}

static func overlap_shape(world: World2D, shape: Shape2D, origin: Vector2, rotation: float):
	var space_state = world.direct_space_state
	var params = Physics2DShapeQueryParameters.new()
	params.collide_with_areas = true
	params.transform = Transform2D(rotation, origin)
	params.set_shape(shape)
	return space_state.intersect_shape(params)

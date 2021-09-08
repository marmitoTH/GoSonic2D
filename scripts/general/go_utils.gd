extends Node

class_name GoUtils

static func get_angle_from(normal: Vector2) -> float:
    var radians = normal.angle_to(Vector2.UP)
    return -rad2deg(radians)

static func get_global_velocity(velocity, normal) -> Vector2:
    var x_speed = velocity.y * -normal.x + velocity.x * -normal.y
    var y_speed = velocity.y * -normal.y + velocity.x * normal.x
    return Vector2(x_speed, y_speed)

static func get_ground_velocity(velocity, normal) -> Vector2:
    var x_speed = velocity.x * -normal.y + velocity.y * normal.x
    var y_speed = velocity.y * normal.y + velocity.x * normal.x
    return Vector2(x_speed, y_speed)

static func global_to_ground_velocity(velocity, normal) -> Vector2:
    var x_speed = velocity.y * normal.x - velocity.x * normal.y
    return Vector2(x_speed, 0)

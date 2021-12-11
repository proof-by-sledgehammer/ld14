class_name Direction
extends Node2D

enum Direction {
	NORTH,
	NORTH_EAST,
	EAST,
	SOUTH_EAST,
	SOUTH,
	SOUTH_WEST,
	WEST,
	NORTH_WEST
}

static func to_vec(dir):
	match dir:
		Direction.NORTH:
			return Vector2( 0, -1)
		Direction.NORTH_EAST:
			return Vector2(+1, -1)
		Direction.EAST:
			return Vector2(+1,  0)
		Direction.SOUTH_EAST:
			return Vector2(+1, +1)
		Direction.SOUTH:
			return Vector2( 0, +1)
		Direction.SOUTH_WEST:
			return Vector2(-1, +1)
		Direction.WEST:
			return Vector2(-1,  0)
		Direction.NORTH_WEST:
			return Vector2(-1, -1)

static func from_vec(v):
	var angle = v.angle()
	if angle >=  0.625 * PI and angle <=  0.875 * PI:
		return Direction.NORTH_WEST
	if angle >=  0.375 * PI and angle <=  0.625 * PI:
		return Direction.NORTH
	if angle >=  0.125 * PI and angle <=  0.375 * PI:
		return Direction.NORTH_EAST
	if angle >= -0.125 * PI and angle <=  0.125 * PI:
		return Direction.EAST
	if angle >= -0.375 * PI and angle <= -0.125 * PI:
		return Direction.SOUTH_EAST
	if angle >= -0.625 * PI and angle <= -0.375 * PI:
		return Direction.SOUTH
	if angle >= -0.875 * PI and angle <= -0.625 * PI:
		return Direction.SOUTH_WEST
	return Direction.WEST
	
	
	
	
	
	
	
	

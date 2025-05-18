class_name Enum

enum Direction {
	NORTH,
	NORTHEAST,
	EAST,
	SOUTHEAST,
	SOUTH,
	SOUTHWEST,
	WEST,
	NORTHWEST,
}


static func direction_as_string(value: Direction) -> String:
	match value:
		Direction.NORTH:
			return "north"
		Direction.NORTHEAST:
			return "northeast"
		Direction.EAST:
			return "east"
		Direction.SOUTHEAST:
			return "southeast"
		Direction.SOUTH:
			return "south"
		Direction.SOUTHWEST:
			return "southwest"
		Direction.WEST:
			return "west"
		Direction.NORTHWEST:
			return "northwest"
		_:
			push_error("Invalid direction value %s" % value)
			return ""


static func vector_to_direction(vec: Vector2) -> Direction:
	var angle = vec.normalized().angle()

	if angle < -7 * PI / 8 or angle >= 7 * PI / 8:
		return Direction.WEST
	elif angle < -5 * PI / 8:
		return Direction.SOUTHWEST
	elif angle < -3 * PI / 8:
		return Direction.SOUTH
	elif angle < -PI / 8:
		return Direction.SOUTHEAST
	elif angle < PI / 8:
		return Direction.EAST
	elif angle < 3 * PI / 8:
		return Direction.NORTHEAST
	elif angle < 5 * PI / 8:
		return Direction.NORTH
	else:
		return Direction.NORTHWEST

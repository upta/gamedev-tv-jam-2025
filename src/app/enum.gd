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

enum CoinType {
	SHIT_COIN,
	DOS_COIN,
	A_COIN,
}

enum BlockType {
	EMPTY,
	DIRT,
	WALL,
	BLUE_CHIP,
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
		return Direction.NORTHWEST
	elif angle < -3 * PI / 8:
		return Direction.NORTH
	elif angle < -PI / 8:
		return Direction.NORTHEAST
	elif angle < PI / 8:
		return Direction.EAST
	elif angle < 3 * PI / 8:
		return Direction.SOUTHEAST
	elif angle < 5 * PI / 8:
		return Direction.SOUTH
	else:
		return Direction.SOUTHWEST

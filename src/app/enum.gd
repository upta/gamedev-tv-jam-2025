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
	# Why can't we just have nullable enums though?
	NONE = -1,
	A_COIN,
	BEE_COIN,
	SEA_COIN,
}

enum MiningResourceType {
	BLUE_CHIP,
	GREEN_CHIP,
	RED_CHIP,
	YELLOW_CHIP,
}

enum BlockType {
	EMPTY,
	DIRT,
	WALL,
	BLUE_CHIP,
	GREEN_CHIP,
	RED_CHIP,
	YELLOW_CHIP,
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


static func vector_to_orthogonal_direction(vec: Vector2) -> Direction:
	var angle = vec.normalized().angle()

	if angle < -3 * PI / 4 or angle >= 3 * PI / 4:
		return Direction.WEST
	elif angle < -PI / 4:
		return Direction.NORTH
	elif angle < PI / 4:
		return Direction.EAST
	else:
		return Direction.SOUTH

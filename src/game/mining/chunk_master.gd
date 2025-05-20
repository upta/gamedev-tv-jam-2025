class_name ChunkMaster extends Node

@export var block_types: Dictionary[Enum.BlockType, PackedScene] = {}
@export var block_size_px: float = 10.0
@export var chunk_radius: int = 3


func _get_block_range() -> Array:
	return range(-chunk_radius, chunk_radius + 1, 1)


## Grid location is independent of block size in px
## It's based on the grid of blocks
func _get_all_block_grid_locations() -> Array[Vector2]:
	var locations: Array[Vector2]
	for x in _get_block_range():
		for y in _get_block_range():
			locations.append(Vector2(x, y))
	return locations


func _get_new_block(type: Enum.BlockType) -> Node2D:
	var block_type: PackedScene = block_types.get(type)
	if block_type != null:
		return block_type.instantiate() as Node2D

	return null


func _generate_center(distance_from_center: float) -> Enum.BlockType:
	if distance_from_center <= 4:
		return Enum.BlockType.EMPTY

	return _generate_default(distance_from_center)


func _generate_default(distance_from_center: float) -> Enum.BlockType:
	if randf() < 0.05:
		return Enum.BlockType.WALL

	if randf() < max(1 / distance_from_center, 0.001):
		return Enum.BlockType.EMPTY

	return Enum.BlockType.DIRT_BLOCK


## chunk block center is expected to be based on the block grid, not pixels
func _get_block_generator(chunk_block_center: float) -> Callable:
	if chunk_block_center < 1:
		return _generate_center

	return _generate_default


func generate_blocks(chunk_position: Vector2) -> Array[Node2D]:
	var chunk_block_center = chunk_position / block_size_px
	var block_generator = _get_block_generator(chunk_block_center.distance_to(Vector2.ZERO))

	var blocks: Array[Node2D] = []
	for block_grid_location in _get_all_block_grid_locations():
		var block_global_grid_position = chunk_block_center + block_grid_location
		var block_distance_from_center = block_global_grid_position.distance_to(Vector2.ZERO)
		var blockType = block_generator.call(block_distance_from_center)
		var block = _get_new_block(blockType)
		if block == null:
			continue

		block.position = block_grid_location * block_size_px
		block.show()
		blocks.append(block)

	return blocks

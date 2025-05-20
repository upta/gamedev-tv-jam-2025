class_name ChunkMaster extends Node

@export var block_types: Dictionary[Enum.BlockType, PackedScene] = {}
@export var block_size_px: float = 10.0
@export var chunk_radius: int = 3


func get_new_block(type: Enum.BlockType) -> Node2D:
	var block_type: PackedScene = block_types.get(type)
	if block_type != null:
		return block_type.instantiate() as Node2D

	return null


func get_block_generator(chunk_position: Vector2) -> Callable:
	var chunk_center = chunk_position / block_size_px

	return func(at: Vector2) -> Node2D:
		var block_center = chunk_center + at
		var distance_from_center = block_center.distance_to(Vector2.ZERO)

		# create center area
		if distance_from_center <= 4:
			return null

		if randf() < 0.05:
			return get_new_block(Enum.BlockType.WALL)

		if randf() < max(1 / distance_from_center, 0.001):
			return null

		return get_new_block(Enum.BlockType.DIRT_BLOCK)

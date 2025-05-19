class_name Chunk
extends Area2D

@export var block_size_px: int = 20
@export var radius: int = 3

var has_spawned = false;

var ordinal_positions: Array[Vector2] = [
	Vector2.LEFT,
	Vector2.RIGHT,
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT + Vector2.UP,
	Vector2.UP + Vector2.RIGHT,
	Vector2.RIGHT + Vector2.DOWN,
	Vector2.DOWN + Vector2.LEFT
]

@onready var chunk_size: int = 1 + (radius * 2)
@onready var chunk_size_px: int = chunk_size * block_size_px

@onready var chunk: PackedScene = preload("res://game/mining/chunk.tscn")
@onready var area: CollisionShape2D = $Area;

@onready var dirt_block: PackedScene = preload("res://game/mining/dirt.tscn")
@onready var wall_block: PackedScene = preload("res://game/mining/solid_wall.tscn")


func _ready() -> void:
	var shape = area.shape as RectangleShape2D
	shape.size = Vector2.ONE * chunk_size_px;
	_fill_chunk()


func _fill_chunk() -> void:
	for block_location in _get_all_block_grid_locations():
		var block_type = _get_block_type(block_location)
		if block_type == null:
			continue

		var block = block_type.instantiate() as Node2D
		block.position = block_location * block_size_px
		block.show()
		add_child(block)


func _get_block_type(at: Vector2) -> PackedScene:
	var chunk_center = position / block_size_px
	var block_center = chunk_center + at
	var distance_from_center = block_center.distance_to(Vector2.ZERO)

	# create center area
	if distance_from_center <= 4:
		return null

	if randf() < 0.05:
		return wall_block

	if randf() < max(1 / distance_from_center, 0.001):
		return null

	return dirt_block


func _get_all_block_grid_locations() -> Array[Vector2]:
	var locations: Array[Vector2]
	for x in range(-radius, radius + 1, 1):
		for y in range(-radius, radius + 1, 1):
			locations.append(Vector2(x, y))
	return locations


func _on_body_entered(body: Node2D) -> void:
	if not has_spawned and body is Player:
		has_spawned = true
		_spawn_sibling_chunks()


func _spawn_sibling_chunks() -> void:
	var physics = PhysicsServer2D.space_get_direct_state(get_world_2d().get_space())

	for sibling_location in _get_sibling_locations().filter(func(pos): return not _has_sibling_chunk(pos, physics)):
		_create_sibling(sibling_location)


func _create_sibling(at: Vector2) -> void:
	var sibling = chunk.instantiate() as Chunk
	sibling.position = at
	sibling.block_size_px = block_size_px
	sibling.radius = radius
	add_sibling(sibling)


func _has_sibling_chunk(at: Vector2, physics: PhysicsDirectSpaceState2D) -> bool:
	var params = PhysicsPointQueryParameters2D.new()
	params.position = at
	params.collide_with_areas = true
	params.collide_with_bodies = false
	var result = physics.intersect_point(params)
	return result.any(func(val): return val.collider is Chunk)


func _get_sibling_locations() -> Array[Vector2]:
	var origin = get_global_transform().get_origin()
	var results: Array[Vector2]
	results.assign(ordinal_positions.map(func(pos): return pos * chunk_size_px + origin))
	return results

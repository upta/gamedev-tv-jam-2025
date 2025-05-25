class_name Chunk
extends Area2D

@export var chunk: PackedScene
@export var chunk_master: ChunkMaster

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

@onready var chunk_size: int = 1 + (chunk_master.chunk_radius * 2)
@onready var chunk_size_px: float = chunk_size * chunk_master.block_size_px
@onready var area: CollisionShape2D = $Area;


func _ready() -> void:
	var shape = area.shape as RectangleShape2D
	shape.size = Vector2.ONE * chunk_size_px;
	_fill_chunk()


func _fill_chunk() -> void:
	for block in chunk_master.generate_blocks(position):
		add_child.call_deferred(block)


func _on_body_entered(body: Node2D) -> void:
	if not has_spawned and body is Player:
		spawn_sibling_chunks()


func _create_sibling(at: Vector2) -> void:
	var sibling = chunk.instantiate() as Chunk
	sibling.chunk = chunk
	sibling.chunk_master = chunk_master
	sibling.position = at
	add_sibling.call_deferred(sibling)


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


func spawn_sibling_chunks() -> void:
	has_spawned = true
	var physics = PhysicsServer2D.space_get_direct_state(get_world_2d().get_space())

	for sibling_location in _get_sibling_locations().filter(func(pos): return not _has_sibling_chunk(pos, physics)):
		_create_sibling(sibling_location)

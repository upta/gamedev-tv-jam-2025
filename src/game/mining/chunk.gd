class_name Chunk
extends Area2D

@export var block_size_px: int = 20
@export var radius: int = 3

var has_spawened = false;

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

@onready var area: CollisionShape2D = get_node("Area");

@onready var chunk: PackedScene = preload("res://game/mining/chunk.tscn")


func _ready() -> void:
	var shape = area.shape as RectangleShape2D
	shape.size = Vector2.ONE * chunk_size_px;


func _on_body_entered(body: Node2D) -> void:
	if not has_spawened and body is Player:
		has_spawened = true
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

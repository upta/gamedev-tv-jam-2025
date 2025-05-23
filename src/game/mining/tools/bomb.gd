extends Node2D

@export var explosion_time: float = 2.0
@export var block_size_px: float = 10.0
@export var explosion: PackedScene

var explosion_radius: int
var explosion_power: int

var exploding := false
var wait_for_free := false


func _ready() -> void:
	explosion_radius = Service.Upgrade.get_upgrade_value(Enum.UpgradeType.BOMB, "radius")
	explosion_power = Service.Upgrade.get_upgrade_value(Enum.UpgradeType.BOMB, "strength")


func _process(delta: float) -> void:
	explosion_time -= delta

	if explosion_time <= 0 and not exploding:
		exploding = true
		_explode()

	if wait_for_free and $ExplosionContainer.get_child_count() == 0:
		queue_free()


func _explode():
	$Animation.play("exploding")
	await $Animation.animation_finished
	$Animation.hide()

	_make_explosion_area()
	$BoomSFX.play()
	await $BoomSFX.finished


func _make_explosion_area():
	var physics = PhysicsServer2D.space_get_direct_state(get_world_2d().get_space())

	for point in _calc_explosion_points():
		_mine_block_at_point(point + global_position, physics)

		var new_explosion: Node2D = explosion.instantiate()
		new_explosion.position = point
		$ExplosionContainer.add_child(new_explosion)

	wait_for_free = true


func _mine_block_at_point(at: Vector2, physics: PhysicsDirectSpaceState2D):
	var params = PhysicsPointQueryParameters2D.new()
	params.position = at
	params.collide_with_areas = false
	params.collide_with_bodies = true
	var results = physics.intersect_point(params)
	for result in results:
		var collider = result.collider
		if collider is Mineable:
			collider.try_mine(explosion_power)


func _calc_explosion_points():
	var points := [Vector2.ZERO]

	for x in range(0, explosion_radius + 1):
		for y in range(1, explosion_radius + 1):
			var point = Vector2(x, y)
			if point.distance_to(Vector2.ZERO) > explosion_radius:
				break
			point *= block_size_px
			points.append_array([
				point,
				point.rotated(PI / 2),
				point.rotated(PI),
				point.rotated(-PI / 2),
				])

	return points

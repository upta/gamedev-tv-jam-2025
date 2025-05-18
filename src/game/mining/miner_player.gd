extends Player


func _physics_process(delta: float) -> void:
	super._physics_process(delta)

	var collision = get_last_slide_collision()
	if collision:
		_handle_collision(collision.get_collider())


func _handle_collision(collider: Object):
	if collider is Mineable:
		collider.try_mine()

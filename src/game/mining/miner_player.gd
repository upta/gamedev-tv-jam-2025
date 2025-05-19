extends Player

@export var base_mining_rate: float = 1.0

@onready var last_mined_at: float = Time.get_unix_time_from_system()


func _process(delta: float) -> void:
	var collision = get_last_slide_collision()
	if collision:
		_handle_collision(collision.get_collider())


func _handle_collision(collider: Object):
	if collider is Mineable:
		_try_mine(collider)


func _try_mine(mineable: Mineable):
	var now = Time.get_unix_time_from_system()
	var can_mine = now - last_mined_at > base_mining_rate

	if can_mine:
		mineable.try_mine()
		last_mined_at = now

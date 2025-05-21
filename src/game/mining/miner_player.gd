extends Player

@export var base_mining_rate: float = 1.0

@onready var last_mined_delta: float = 0.0

@onready var sfx_hit: AudioStreamPlayer2D = $SFX/Hit


func _ready() -> void:
	$AudioListener2D.make_current()


func _process(delta: float) -> void:
	last_mined_delta += delta

	var collision_count = get_slide_collision_count()
	for index in range(collision_count):
		var collision = get_slide_collision(index)
		_handle_collision(collision.get_collider())


func _handle_collision(collider: Object):
	if collider is Mineable:
		if facing_direction == Enum.vector_to_orthogonal_direction(collider.global_position - global_position):
			_try_mine(collider)


func _try_mine(mineable: Mineable):
	var can_mine = last_mined_delta >= base_mining_rate

	if can_mine and mineable.try_mine():
		last_mined_delta = 0.0
		sfx_hit.position = mineable.global_position - global_position
		sfx_hit.play()

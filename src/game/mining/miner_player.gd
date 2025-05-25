extends Player

@onready var sfx_drop: AudioStreamPlayer2D = $SFX/Drop

signal drop_item(item: Node2D)
signal update_bomb_action_time(time: float)

@export var base_mining_rate: float = 1.0
@export var bomb_action: GUIDEAction
@export var bomb: PackedScene

var base_bomb_rate: float
var mining_strength: int

var can_mine: bool:
	get: return last_mined_delta >= base_mining_rate

var can_bomb: bool:
	get: return last_bomb_delta >= base_bomb_rate

var bomb_action_time: float:
	get: return base_bomb_rate - last_bomb_delta

var last_mined_delta: float = 0.0:
	get: return last_mined_delta
	set(value):
		last_mined_delta = value

var last_bomb_delta: float = 0.0:
	get: return last_bomb_delta
	set(value):
		last_bomb_delta = value
		update_bomb_action_time.emit(bomb_action_time)

@onready var sfx_hit: AudioStreamPlayer2D = $SFX/Hit
@onready var sfx_nope: AudioStreamPlayer2D = $SFX/Nope


func _ready() -> void:
	base_bomb_rate = Service.Upgrade.get_upgrade_value(Enum.UpgradeType.BOMB, "cooldown")
	mining_strength = Service.Upgrade.get_upgrade_value(Enum.UpgradeType.MINE_POWER, "strength")
	speed = Service.Upgrade.get_upgrade_value(Enum.UpgradeType.SPEED, "speed")
	$AudioListener2D.make_current()
	bomb_action.completed.connect(_try_drop_bomb)


func _process(delta: float) -> void:
	last_mined_delta += delta
	last_bomb_delta += delta

	var collision_count = get_slide_collision_count()
	for index in range(collision_count):
		var collision = get_slide_collision(index)
		_handle_collision(collision.get_collider())


func _handle_collision(collider: Object):
	if collider is Mineable:
		if facing_direction == Enum.vector_to_orthogonal_direction(collider.global_position - global_position):
			_try_mine(collider)


func _try_mine(mineable: Mineable):
	if can_mine and mineable.try_mine(mining_strength):
		last_mined_delta = 0.0
		sfx_hit.position = mineable.global_position - global_position
		sfx_hit.play()


func _try_drop_bomb():
	if can_bomb:
		last_bomb_delta = 0.0
		var new_bomb: Node2D = bomb.instantiate()
		new_bomb.global_position = global_position
		drop_item.emit(new_bomb)
	else:
		sfx_nope.play()

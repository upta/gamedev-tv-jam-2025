extends Node2D

@export var input_context: GUIDEMappingContext
@export var total_mining_time: float = 60.0

var done = false

@onready var time_elapsed: float = 0.0
@onready var time_left: float = total_mining_time


func _ready():
	GUIDE.enable_mapping_context(input_context, true)


func _process(delta: float) -> void:
	time_elapsed += delta
	time_left = max(total_mining_time - time_elapsed, 0)

	$MiningUI.set_time_left(time_left)

	if time_left <= 0 and not done:
		_end_mining()


func _end_mining() -> void:
	done = true
	$EndMining.on_time_up.call_deferred()
	$MiningUI.visible = false


func _on_miner_player_drop_item(item: Node2D) -> void:
	item.global_position = $ChunkMaster.get_nearest_global_grid_position(item.global_position)
	add_child(item)


func _on_miner_player_update_bomb_action_time(time: float) -> void:
	$MiningUI.set_bomb_action_time(time)

extends Node2D

@export var input_context: GUIDEMappingContext

var total_mining_time: float
var done = false
var time_left: float

@onready var time_elapsed: float = 0.0


func _ready():
	GUIDE.enable_mapping_context(input_context, true)

	total_mining_time = Service.Upgrade.get_upgrade_value(Enum.UpgradeType.MINE_TIME, "time")
	time_left = total_mining_time

	# Prespawn sibling chunks for first area
	$Chunk.spawn_sibling_chunks()


func _process(delta: float) -> void:
	time_elapsed += delta
	time_left = maxi(ceili(total_mining_time - time_elapsed), 0)

	$MiningUI.set_time_left(time_left)

	if time_left <= 0 and not done:
		_end_mining()


func _end_mining() -> void:
	done = true
	$EndMining.on_time_up.call_deferred()
	$MiningUI.visible = false
	AudioService.game_music_mining.stop()
	AudioService.game_music_home.play()


func _on_miner_player_drop_item(item: Node2D) -> void:
	item.global_position = $ChunkMaster.get_nearest_global_grid_position(item.global_position)
	add_child(item)


func _on_miner_player_update_bomb_action_time(time: float) -> void:
	$MiningUI.set_bomb_action_time(time)


func _on_start_countdown_on_countdown_finished() -> void:
	AudioService.game_music_mining.play()
	$MiningUI.visible = true

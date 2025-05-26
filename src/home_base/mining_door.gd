extends Node2D

@onready var interactable: Interactable = $Interactable


func _ready():
	interactable.interacted.connect(_on_interacted)


func _on_interacted():
	State.Inventory.held_coin_type = Enum.CoinType.NONE

	if _has_remaining_chips():
		get_tree().paused = true

		for resource_type in ItemTypes.mining_resources:
			var remaining = State.Inventory.mining_resources.get(resource_type, 0)
			for i in range(0, remaining):
				Service.Inventory.refund_resource(resource_type)
				AudioService.making_power.play()

				await get_tree().create_timer(0.1).timeout

		await get_tree().create_timer(0.25).timeout
		get_tree().paused = false

	State.Scene.active_scene = "res://game/mining_area.tscn"
	AudioService.game_music_home.stop()


func _has_remaining_chips() -> bool:
	for resource_type in ItemTypes.mining_resources:
		var remaining = State.Inventory.mining_resources.get(resource_type, 0)

		if remaining > 0:
			return true

	return false
